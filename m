Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB82C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FF510E733;
	Tue, 22 Sep 2026 15:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="SnMCTWvG";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn19013077.outbound.protection.outlook.com
 [52.103.35.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8314B10E724;
 Tue, 22 Sep 2026 15:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMudwO/tQxP5QM50xHRTxFkgMD8tQek9LlLpx+42oZkNlRsuyLceJvpJpNQ7Nni05/e4nWN0xR7LMSh6GUMCssqOYhG9s3Ls5+C9VV5hC3cOTwTT0XDFYD/NPe9RyffTicunJGLSCcQh3s2iWyfFaNBI7S5q7XGdpG0UhHKKPngazTeO/zBPRLQB3z5pWZuPvIp21MOvDULHf241v/LhfY5w4pkCB+SnJ06rznr97st8wMRjGVtpiS76ffoZtfvnyXs9nn1EMqWFFgkoYF6aE6X8sNlWkgr6N2GJ7RR/7FJJE4v0FYTKhVDqU6RsdeFsE7QyMfcX1nsNXiartY8+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVOThFB2rO0F6mzi2SAwTMtbakFPYaRGKixZKaFKjbo=;
 b=YgYWdMGlj/5qZqiQLvcx89UgYvwN6MalazoJcwwAzCxHLYqlabmj3IAZVa+7bUlFEfeGixqMzqzxNQO/+VJErgSkrl5Uj/gAii03ylKyaj6f784vCZ+b6wCMmdQslu3T3J01ECfS/E93mM0WPIWZxESNepAMTrKChIQRpMX0ssVjNYSHRYKFaRwNqiReTdrsveiX3Pp/tXNpx+ByIcPXTfYhCdA9BFpcPhzw3Q9VA22cKyu6IlthjzVlVYEvGEa0FL5IQR4IAuo8WJPqgR/9kHIxGm49KLdt3TMn+h00Sk8FLYG/047pQy2Qk/sHSepBQfQEUM1Mk09acTrBSpp6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVOThFB2rO0F6mzi2SAwTMtbakFPYaRGKixZKaFKjbo=;
 b=SnMCTWvG5UjUttHrEIV3zkLRDJBtSLCuc0xmXYiYAlGN4b6vVt6FeaLJHbuUcHTMSeSp88x3zZDIkWgLo9Lqc5mhar4cYsYc/UM+Mc4/4Dr71obhtN5rHn26WvjHHSlLFqgaTK+5pSJkokCEkkyCtfgZdQj3S2H0YFcHBI2kXW+ZwOSsn+6GNrWtztxUNSkJSxBGGHh7avPZYOzD+k+0NdjjR7Oslwj4VLl2tUPkbHQtT7Ssa9Ki+WUZ6dC2XjnObHLjbuREokOp/rW29iZQyijJhMNLLVrL8f1XE7caH0IalX9gZBw82MzL968Ted96LNYwgFxDUtwerpwgqRh1sg==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by DU0PR03MB8743.eurprd03.prod.outlook.com (2603:10a6:10:3ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:53:44 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:53:44 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: [PATCH 2/3] drm/amd/display: skip destructive HPD verify on live links
Thread-Topic: [PATCH 2/3] drm/amd/display: skip destructive HPD verify on live
 links
Thread-Index: AQHdSqqLs3qmfrPHkU2kT+TseJt1sQ==
Date: Tue, 22 Sep 2026 15:53:43 +0000
Message-ID: <DB9PR03MB7388AD5607A0A66DF2D477EB8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
 <DB9PR03MB7388900446938D7712613C9A8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
In-Reply-To: <DB9PR03MB7388900446938D7712613C9A8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: 7ea8b395-4588-4ea4-df43-08df18c1ae39
x-ms-exchange-slblob-mailprops: 7qh87CJt6y1mqZO6407WRLxlypE3k+ejgg6l51BPge5KM5lH1zU4/CeobfR+IxPYRe+/Dxv62ry9Xq13KF+RxW/oaEI4GZPKeyT8NH78Bv9aSaDJ9XN+XGbEi6AR5rVsHbH1BynjbjRGkLQXd0pganIhBTJLgZsSC2/cCXH7fCCe6HiUYkPx21ou7BXiuCycXyu2JUumBmHVjQo6vHHDP02Q07OLTfsNK+CvrJgSkK9UBhyJoCxnIxjLpaTFE1j36OHHKclexXbZATGYCrJOtXSCsd2S0F2Mna2dj7TsTna0CCP1qk8e4YyFDHDqWxSfxuheWos7zK5080Yq4eUUBtbfDPbk0dHLPElzF3RepVbQBg+bZWAf78JyLwFbyWscoR1WZ2ebcEurhuXMzLD+yoiUSiRv1FfSr+e+coaS/0jjJ4a3uTN2fbsSs14BSErl52JQ9pFVFGQPSILlsYplMWWgLZDdx4p/Mpl6D1BH+0RUiwRzunBnY7LL7H7aA93w3Zo4mRK5agJxs5bbQ66TKfjsfFQaLO7LEO/4a9w7S2pYYUjJZ792bhluyxKhFZCCxaZXjor5kxFQybTwnEARjJ6LIrlGPDSa+4Xj5JIouZwpdkuNA3vfZsTxBNwDclq8ewZpsShgbKk/BKLz9/njfO7eVYKeXmD6NVVaaxss09nChP1OYdoO8iHp5N9vkqRTbaRZzO90ok2HKbVulZHMhWaXftM4k6XZjWTcLpQLHW3fgHSXZ5h5GjLJlw6H7msA
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|19110799012|8060799015|51005399006|25010399006|15080799012|37011999003|31061999003|15030799006|21061999006|24021099003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lmnQysAIs5x78KrzVHdvRG6e0iQwLzyGoL5ji48v22MeTFakOJphkFn3M3?=
 =?iso-8859-1?Q?ulnyES3B10R0Lc6LaU1s/ggZa7eV7wS5twwucwU+R0LKeA3rLEe1kcm7w4?=
 =?iso-8859-1?Q?JX5ssexTpfZfwoEtuDC+UeN4fCb73TG61QFB8UZ5O2am+x5NI9vlcTArpQ?=
 =?iso-8859-1?Q?vQmDFdx1iKwDFhguzd0FmuROWZYVLYNq+JqE+J8jtE4rcvb0Oh21+7kOLj?=
 =?iso-8859-1?Q?WmsBep4ELO26F6JAI0dapfrHLQlkds4YRGyoihd8DkdBaNaQZEB/QpA6QX?=
 =?iso-8859-1?Q?6RHuy3ZPjHjoEG0NnA8OGln7eOztqJzVNbk585lD0n3IYVO3Vo9V4g0/N4?=
 =?iso-8859-1?Q?QaBberb+XxW8by5/1wBSdIJnQwv+P3r8SepDozFkW+8MPr4RrawRi4FWS3?=
 =?iso-8859-1?Q?ze5Ao2wrrNa6TV/5CUtfVIlpQeIRNZ4Sqqvkp3bbc+DYHgPrY15VN8W+I1?=
 =?iso-8859-1?Q?MExrnApUNv4gvspM+kfLgVO+4kD/Y05gmNNWpFCNwywSvSYeyq3D9JV2pu?=
 =?iso-8859-1?Q?G+FBryi3DUAbZE9kO9Vq6AXdSWvLi0Ska8Mzz1dL00jx827m18Y8HSWMie?=
 =?iso-8859-1?Q?OmRMFI4U/ZLQfEkAbHgPcYtekdzWz2Hu3s6La5VxFjVq9FYI3QeuN1nAJP?=
 =?iso-8859-1?Q?urwOS2KvDFBnl/4vIS6MBqNj9pBY1osHKMmkYiXIy3Y0/FSBDVjYTv5VXu?=
 =?iso-8859-1?Q?XhzaQpdzHFBwJIuiswN6amlkJq95bWnNlxAPQXQZqvFTaohQAqxFh+fhM9?=
 =?iso-8859-1?Q?PB0YQw9+LComzHyvLUwjKIz+h7qD1y9YNqWDTmERFK1QM16YJQjsneFXS2?=
 =?iso-8859-1?Q?rDgNel/7H85JFpsnKPEBkOBcCIqGKvnbtmT5+JrF+0VEy8Ac8dZebtEm3N?=
 =?iso-8859-1?Q?SDQMoi8rVojvBnSzDFlV5aXf5sNZ1nkQGaoGPVoEgFH5ht2SkZOG0VYSQx?=
 =?iso-8859-1?Q?cBdvOVXc5l8Htol+/3eDdNj3oECjHikycPEbOmvSYSN/PSvpZ3cbTHaBIg?=
 =?iso-8859-1?Q?LCog0pScEO809N9e/+bgcOTGloOcNU+81O5iqXHv3e0hG54Vo/KAEkfoX6?=
 =?iso-8859-1?Q?yJDDfIqWReRb4KGX529eEMY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VfgZY+j6bPZJBIjd776udNueffZFHIm3D5szezs6voJmT/mtb9SsC/tiTf?=
 =?iso-8859-1?Q?rVmgM1nJJyoXu9z5F3NmiCLlFj4iN3FGXFcnS6jauupqDhBlFDXY2/OlSa?=
 =?iso-8859-1?Q?42RZqLwscY95jDnmcwpusg7jjWUglpRWwAS6JbRQfLkXqCY0TeTQ/p2ENg?=
 =?iso-8859-1?Q?3oGYdbofRBAYxsxZPzZl+Uj6cM9xx/R9C5MVLINCCZ7l2PvzZURx6IjR+e?=
 =?iso-8859-1?Q?0CpZ6PhigvTdZwZ+LOnpHixlKJx8M9XxB99NWiFHc8+pS2f/zc+3Hdc06A?=
 =?iso-8859-1?Q?AHM7Qw/J7TlzVugEg/bfU7q+JhLP6wq+tVxgAhWArpXgD5HI31a7KNaKmb?=
 =?iso-8859-1?Q?4rAtk0FQo2Ip418ocenN6jsphDCwrgiBkoC7sOPdLo0MSyWG9jJVFeyZs1?=
 =?iso-8859-1?Q?3/uzTb5PdovyEK3nD3UABRMraKC08gV+E97hSUefIgeJvnj/eOxhFs02Pa?=
 =?iso-8859-1?Q?AQ4EmDSi2cd0sDsGh99S5xgrCCyw3q/Y11aQIooHJRgHLCwpymb4ULRF0V?=
 =?iso-8859-1?Q?aIEFq4RieJxwGce4cXJBM3ZCOgEhtj+Uy9rAoio4SyUnMDV+WHudVc5B1v?=
 =?iso-8859-1?Q?64SrVxuoaH/CWURT0UEwH9h0t8B2r7sFEAMWLd4jx8FxSB47nXftYWblkf?=
 =?iso-8859-1?Q?TgCXxH4VFLrdxJQz6sJEfiqJDZEAHyNCn2zIV6rbh5/5fWAN1AEmVWQt6p?=
 =?iso-8859-1?Q?tEtW6Xdr5sh1n+lclh7ZkjL6HRsxz6sk547Hom6B6Oi5hUeK7P0QIXb6Me?=
 =?iso-8859-1?Q?u008tnUATUnFsUmqrQKdVSn4wenkL5/wJpaIDnO3mfsOlD8ENAxEK7Dx3j?=
 =?iso-8859-1?Q?IwAEUrUNPohZlee++nYSmGpZUDamyrLAG5jts2ytQICW+/dELzbFPfit4o?=
 =?iso-8859-1?Q?nThUmPASHKONEiStpKq2+KVPISBTjoVP+6wW21u5U2PUG23REC8kzy0zaG?=
 =?iso-8859-1?Q?ZtymxeDKCwsReECymJv1zvoSvJNRGWN0NCZPlj39nHy+LuymRbVB9yxGMu?=
 =?iso-8859-1?Q?rnZNjLiJ4MkUm9JwWqfxo1iATHCSzrm1FwVpu2M+staHR2X/bynldFVnDU?=
 =?iso-8859-1?Q?mqVkS+tr9MkgK0ILj4ldV1WosiW49xB9qgZsQH2TqtOr8N4GNfAclXwRSv?=
 =?iso-8859-1?Q?sx4VLQ33sr7xCRkmS9YCtyelSAhQdvioyrC7SmvRqz/JOWn1Dy1lzoaeE9?=
 =?iso-8859-1?Q?zIbxzMuULVLEinkcPfGlFG1Qq7VAbr/lRyF/31opp18oxtCb7lvYGbPDF/?=
 =?iso-8859-1?Q?8kjkGXG7tXez+ZIFppmxDmXWInU9kQghwoc5k64Xk1tw+5BKN9/xg2uL4g?=
 =?iso-8859-1?Q?I2dyqjZyPJK1fxHG6i280exrP/wuf6dJlYxTIKlmutD4SHRM8D+6GMSfLG?=
 =?iso-8859-1?Q?+/+gYvDsDod+q5bsPhfq2fGVk8kRGn6AD0bmz2bSfWNwfBQ3VuO/ymrSbm?=
 =?iso-8859-1?Q?bO4BWhtJ9d9sFjDg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea8b395-4588-4ea4-df43-08df18c1ae39
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:53:44.0049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8743
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From 242fdfdef877fd756a789b1bba8323fb1de0b594 Mon Sep 17 00:00:00 2001=0A=
Message-ID: <242fdfdef877fd756a789b1bba8323fb1de0b594.1790083445.git.arthur=
_liberman@hotmail.com>=0A=
In-Reply-To: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
References: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
From: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
Date: Mon, 21 Sep 2026 01:41:29 +0300=0A=
Subject: [PATCH 2/3] drm/amd/display: skip destructive HPD verify on live=
=0A=
 links=0A=
=0A=
Destructive link-cap verify DPMS-offs every live stream from the HPD=0A=
worker via dc_commit_updates_for_stream(). DP takes that path unless=0A=
the link is embedded, training is skipped, or dpcd_caps.is_mst_capable=0A=
is set.=0A=
=0A=
detect_link_and_local_sink() re-reads DPCD before=0A=
verify_link_capability(). Switching input or powering off an MST=0A=
daisy-chain while the CRTCs are still on can clear is_mst_capable,=0A=
so the MST exemption no longer applies and detect takes the=0A=
destructive path before MST rediscovery.=0A=
=0A=
Keep the non-destructive verify while the link still has DPMS-on=0A=
master pipes. Userspace will disable the CRTCs; a later detect can=0A=
train.=0A=
=0A=
Fixes: c282d9512cdd ("drm/amd/display: factor out dp detection link trainin=
g and mst top detection")=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-by: Cursor:xai-grok-4.6=0A=
Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
---=0A=
 .../drm/amd/display/dc/link/link_detection.c    | 17 ++++++++++++++++-=0A=
 1 file changed, 16 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers=
/gpu/drm/amd/display/dc/link/link_detection.c=0A=
index 12fd4fd24a90..66fb3bc06a1f 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c=0A=
@@ -960,13 +960,28 @@ static bool should_verify_link_capability_destructive=
ly(struct dc_link *link,=0A=
 					link);=0A=
 =0A=
 	if (dc_is_dp_signal(link->local_sink->sink_signal)) {=0A=
+		struct pipe_ctx *pipes[MAX_PIPES];=0A=
+		uint8_t active_count =3D 0;=0A=
+=0A=
 		max_link_cap =3D dp_get_max_link_cap(link);=0A=
 		destrictive =3D true;=0A=
 =0A=
+		/*=0A=
+		 * Destructive verify DPMS-off's every live stream via=0A=
+		 * dc_commit_updates_for_stream() on the HPD worker. That=0A=
+		 * races MST teardown (input switch / power-off while the=0A=
+		 * displays are still on) and can NULL remaining pipe streams.=0A=
+		 * Keep the non-destructive path until userspace disables the=0A=
+		 * CRTCs; a later detect can train.=0A=
+		 */=0A=
+		link_get_master_pipes_with_dpms_on(link, link->dc->current_state,=0A=
+						   &active_count, pipes);=0A=
+=0A=
 		if (link->dc->debug.skip_detection_link_training ||=0A=
 				dc_is_embedded_signal(link->local_sink->sink_signal) ||=0A=
 				(link->ep_type =3D=3D DISPLAY_ENDPOINT_USB4_DPIA &&=0A=
-				!link->dc->config.enable_dpia_pre_training)) {=0A=
+				!link->dc->config.enable_dpia_pre_training) ||=0A=
+				active_count) {=0A=
 			destrictive =3D false;=0A=
 		} else if (link_dp_get_encoding_format(&max_link_cap) =3D=3D=0A=
 				DP_8b_10b_ENCODING) {=0A=
-- =0A=
2.55.0=0A=
=0A=
