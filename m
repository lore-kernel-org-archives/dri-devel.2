Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08542C98307
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498A210E72F;
	Tue, 22 Sep 2026 15:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="QvrQ7z5j";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn19013076.outbound.protection.outlook.com
 [52.103.35.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EE610E72E;
 Tue, 22 Sep 2026 15:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdoyVto3OtxeP7Soz+fwTHVsPnM7k5rTIVnastSAxuP4ZKF5rNi7XW603wnO6iomJoVRS+UrRoXbGWpa0VIM8I4vo9JESRGsvESgnznKbY4Kb9+w0iAzslj9BDICxHWSyN5pEkwFbmAvLRq8nDgY7D7ZJfj5pwDdHQkKVEiO02nC2QwWUnMsOelTP5+tRBRK0n2n1/0qn9W871TzrOzPqsDIm1dL3kRRJqM6DQa27zHaGP1+jHz9QxN9ou10D2sIRn+g87aHrpRGE5qLErDGZgvpvhbTK74FDmML1umYtkFHNTIuedp+ARsufM8mBjelAbXeEWWx671atdxLDPorHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiGJPu6XQOXTxP2MsGsxLsyYmBsdWUADwVunufnDBHM=;
 b=J/LKQOtk56dae7k3ogwpS3y1Lpeya3M98i2aSUSTXqcaWuK8/EJlevm7dWS2Nsltv6LPD2+7MzrCe2PQGYfwyyNIqavj8NZTQAjhkmXkegA7BZxsaYHBKaHERVqcSATmKjd3TErTROjQxl5cYUHXGM0ixC/mHaPZNO8RMBhIlr1Hz4fWQyRyIEAQrfo7z2bzB6y1w4gBvEPQb/lmGc9PkRadg0HVdk9+pecbLmNSlMjXcVHHQjOiV9dU57ZVnTqhKdv6Rup499oO5mUOGqf4xV5H4ykx/5RFm1puawWCW2xLvuVwmmJ6+eX/vhrJD1Gvr0fF5oCtpnnNTgYETN91gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiGJPu6XQOXTxP2MsGsxLsyYmBsdWUADwVunufnDBHM=;
 b=QvrQ7z5j58Kvqe4OczZHlOs5B7xetahXe6pn1b/F5a0mlERXr1MzWm/MdwNvsbyI7KXLD0my0a2YanzyFzvskzmDd4cdwuPZxFPwiE2Cx5NiASvXClCZLQO0+BuWAbg3H6xo0t3riQkhgF9gYIbgGl+jysjs5tDFuDLOLYUyWtWMK1FfXBKHW2R47OQ1y4ljVMSZQ+pCSp89D2BI3mTWPJ4h1+zWUGNC4VDUiCsot1o/d2SQC9odhVKHnz3/KR6futFn7lRMgnKTcaUIq5NG8z+IOs6+DaiRSPrFxnZQJMBZw3gbFEdf1yRxQerFbKAiqLA5nmlngB3hDF6UTIcJnA==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by DU0PR03MB8743.eurprd03.prod.outlook.com (2603:10a6:10:3ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:53:02 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:53:02 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: [PATCH 1/3] drm/amd/display: fix NULL stream deref on MST DPMS-off
Thread-Topic: [PATCH 1/3] drm/amd/display: fix NULL stream deref on MST
 DPMS-off
Thread-Index: AQHdSqpyDHSPp/UimkiniOvaO+3aFg==
Date: Tue, 22 Sep 2026 15:53:01 +0000
Message-ID: <DB9PR03MB7388900446938D7712613C9A8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
In-Reply-To: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: 3a0f1232-4ea5-423a-1d3f-08df18c19526
x-ms-exchange-slblob-mailprops: 7qh87CJt6y1mqZO6407WRLxlypE3k+ejehlpddLZeYJhp5aubD9h6XX7qv92vhRR2lbpUfJaQrOPNn9F/juObYyF1rBd0ev505acuHwCm9T6NMfzWi+PI7QG33I3vRudu+wLaMjwpkqlsSHHp75tH4oD0GVaV8850n2IGfESpK3pD8xMLTRLJIcICqRkC+yrtiohy58KosQAQZHXbIb1iRPABiM+qLCol4R3VaA5DUV1TA72r4cRCCPdDdOeMJYNX2X0YU38m6GgdEcJ6xbBwUL35cYYInC8GNDjEC0ROgDhoSNj426WMWrVnTAUlu+C2lVdsl/U6b7jtrfJLEy0BMTlROF60U/shDfvYlr7fydTZuYVBc89QEyNDEy3VPARYFhBEu5GSHHpBAQ+d3P//zBH2j5meYUOsG+AN/1OQL3w3sUe+u0oBA/6qFjD7iTxN2s/y7W/xHCj/PdUdfa8KPCw+HSfMtJFDFvzKpYABYTEep3R0IiMkrorv6kWw/YGKqNyB+BHyBFJ4o8zC0bbL9ZQOyaAZqQub0vMCUuEU1HEA/TJGoB7L2qeTQRJoXIozg5rjr+eSGb+WdxGc4I9Cs8v4VJMgKA3Rsmzsu7GaGhzPWBtrM/LlvMJx1OnwOec9H4DIsZHe7F4jDtjm4u7C1WnfoatNfvxHS2ZqVPOBnuGNjj941ViR3SLPGlVTuT7+MGEwC0cBG2tYkSPA944h7ZLk9Fgv1UkSaal3SLF+Awyj48u+Htq6KompQMxaXDa
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|19110799012|12121999013|8060799015|51005399006|25010399006|15080799012|37011999003|31061999003|15030799006|41001999006|24021099003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4Qbi4GN3Zj90KFG8WfjD32XEElVb7oJb6JwxN54GvrwuYEmyjWNmXQiof4?=
 =?iso-8859-1?Q?axgQUXSZPbXOWslqUHigPiouXbjFttCgXrU46QmoH7/CkDIPgP/PL4h/0F?=
 =?iso-8859-1?Q?zp/TnteaamnEIdx3jSrTLuMQcU881hON8VjGldyzOsRO2iLSvmYV93z9UQ?=
 =?iso-8859-1?Q?Dx/i2ngagihAjT5RJUgXtaay8+eztRWmMKoNl3bSIXIQ/frTRSk5/LIQFG?=
 =?iso-8859-1?Q?uP7YChTLMY+BFQcwiYHOKyhdUXeX4D/LDYY2s8VmmaFzT0II2ZdNC4Y3BU?=
 =?iso-8859-1?Q?agRTn8OVTnJiJMxt9XWGQ3bzRUfM7zGFOnZ0IhFcZLb5rlVwaWhlPyTl8S?=
 =?iso-8859-1?Q?/o/1IRIOnpEJW0vH10uf9v0TBNqmtFN4ZKjtFMKau1Rs1Q7hmIXluNw6Mw?=
 =?iso-8859-1?Q?c7vE149Pr0r5W577mAD8UevYGeQgZ5XrWaJV4PrQ5W4T9R2DvEAJw4sGV9?=
 =?iso-8859-1?Q?iNQ8jid5OAmqsFSlmEb2iaBKwDtKwzLIp/tTxmLFJw8Mb14QcnEIRupBp7?=
 =?iso-8859-1?Q?cK7kUrugtmhBIS/ERmh5fEu9EILpNCnSLwC8mRcxgCxi6+kPm2ktHg/H2k?=
 =?iso-8859-1?Q?2EweBsNtWcSoDnD0uTuPSzNNV3qgbYxWOiHWyHqaH9N260xtiApnfBZHzo?=
 =?iso-8859-1?Q?drvdb1UWkvMqRzOwY27J62FaRS8R5FpatUUWDNHoaXpV1ucT44i1mJ2tF9?=
 =?iso-8859-1?Q?gYwZqYQa+qUM/t2Yws5l2KvEmySQ5ph1TAJyHWT7/xX+a2QOCUk2yXkmoW?=
 =?iso-8859-1?Q?o+qMRKGiEsFpFS18IMvVaZTw9497Q3FGy6xbdFjJCN84wTPxTt1zbiNm00?=
 =?iso-8859-1?Q?DoBFfsnX5R3LWWIWwFFPl1EmsyD+HnjKO9RqIGW+nWUnChnqcqPOBWcA+p?=
 =?iso-8859-1?Q?xV60DXsbFT0b9JYBUr9AxgUB62jcl0Ece8ZrkL8Ly7gUlEnv8K5QeV2xc7?=
 =?iso-8859-1?Q?h9Oa9xbRpEzR3jP7CQuIKfO1+UFiBuVPW/hTVcEdpMUFgKnLPnYYiSUhtB?=
 =?iso-8859-1?Q?PqbMb8LWO+NehpK/sL5HupIh4POFQ8vi9UM+7BJ+3JePRsN8H2QSYjndoi?=
 =?iso-8859-1?Q?2Q+U6qJDq2E5O4NzYypxAcYcXBy5gjsFB8DWuCacZp7G?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3+rTKhgOz7D7GvbuXhTDBR8fPpZpiUlXFfEt6DNpxLSOF/v3UJT/qjLLz1?=
 =?iso-8859-1?Q?djbcGxta3nMGhJHfOrM1tyT4oWaxbp9gJA454qqPMl56hvcXUga7ZvSCyi?=
 =?iso-8859-1?Q?dc0ExifcrHm4TknKOHzryvJhPQ5tw3zMVgEPG9ziB4BLj738UcQfmu7Yey?=
 =?iso-8859-1?Q?qlEeKcHjgVpduwjarOlro/yPDNVyJJnErpWWk8GLN7uYJklZscpBUrEH3F?=
 =?iso-8859-1?Q?Kh1x6MC8GnzlWKSLGynmB1o1fTbDlZn1G+KUI0ReeEY76mlB76mlITqyca?=
 =?iso-8859-1?Q?g2myoVf/eH82Yi2TwgFq2daR3jPJ+2IIh8oB89JJUbzwJ5I6+72bxic9oO?=
 =?iso-8859-1?Q?KoymEBJPIDeflONwMB5HMiJPEc9sF64WfdiPjQ6gQ2COntpde/MWXOnBI4?=
 =?iso-8859-1?Q?+FFNpE2uG6cH4uZMdVEDSPYlLrcBLvLoQJtsmYB6Oba0Rq3xsqxxbacpls?=
 =?iso-8859-1?Q?VSBmjTZMddU1pYXNZQt9ERzm7ErCXP13dATf7Xt9ckupT4HzWznCjiTBzG?=
 =?iso-8859-1?Q?QASmT9oRmC7+cY0qzKY3ZrPJB5J5g+36AUHqgaBoDyjuJhnP0t4on4A0w2?=
 =?iso-8859-1?Q?nktrW06nPLBIO2ctWjwdcuXsM2EfcFvkYcoAfILZ1dy0TrFwDtAZDMIT3b?=
 =?iso-8859-1?Q?aMfnbc6y3X1eTIirGIKTXk22WRcdplQKnNMwkAcwWgMt//gOLkew+9ZoaI?=
 =?iso-8859-1?Q?gY9unlT0dNbFEPHiiYBghg7FDjh5hy+YvHLqEBQ9aqrj/I+8DU4+v0h5uh?=
 =?iso-8859-1?Q?rkG0Jr57hz/jj+m6DcY62CUfdnlGmcivtu3dx88D5uRDkdQVckbuhsb2Yr?=
 =?iso-8859-1?Q?Z55deWuzWDUEwFt3JQUYOCpi0OQaTZzroQyByLiXXZIsEsCuCo4AQ04Xjh?=
 =?iso-8859-1?Q?LXEN3ssugMgLS8iy2j4PSyPtNeEqRKRRMH64Dn700TE3e7+N/3ik3envYP?=
 =?iso-8859-1?Q?6za1/NbaUa43y8UVTKHO8AY0Izgi/MzWCN2tDwSFjgtrfSklYUg6r0S+wZ?=
 =?iso-8859-1?Q?4H1PmEOAytLhEnW0Obp6hRVbOzbIgOz7EA5GEKA82ZxOystvAWLjvGE4bS?=
 =?iso-8859-1?Q?N3imWrG7LCEZuhZz8mwBY4a9h7mrTlkkQLM4WjNEyIVW7gQHmBG2AdyefI?=
 =?iso-8859-1?Q?geewRLk0H80K64g1wLjVBCv2Qf3+F5dLN3rkmmvKS59dqC+QSZV1Cay5KK?=
 =?iso-8859-1?Q?Bs7q5j+6U6SqxC9WpqxoE+XuPrl6weWZ2bW4sGBiC5O9uMAGxtM7dVHprJ?=
 =?iso-8859-1?Q?rXXt8HWJIKUhnV5YPJWrkQwi3QIRCdKFNwu6p9R9CVGvg5EcNIljEWOLCV?=
 =?iso-8859-1?Q?78oweanNTg/z9Z4u/Pd6ZaWZ9m01Pd6ymqHBd5ThNokMe1/LKanSE41hHH?=
 =?iso-8859-1?Q?a83aAW0+SBgusDSzFoI4ZlXaaTFCDfr+14DOeEFtsaLiBZpZgbl3PcAekZ?=
 =?iso-8859-1?Q?mBFxYphDnajhLesb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f1232-4ea5-423a-1d3f-08df18c19526
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:53:01.9486 (UTC)
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

From dff1f3ce5f313dc88503c1da01c959638b7d42e4 Mon Sep 17 00:00:00 2001=0A=
Message-ID: <dff1f3ce5f313dc88503c1da01c959638b7d42e4.1790083445.git.arthur=
_liberman@hotmail.com>=0A=
In-Reply-To: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
References: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
From: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
Date: Mon, 21 Sep 2026 01:41:20 +0300=0A=
Subject: [PATCH 1/3] drm/amd/display: fix NULL stream deref on MST DPMS-off=
=0A=
=0A=
dc_stream_get_status() and dc_stream_get_status_const() load=0A=
stream->ctx with no NULL check. HPD detect of an MST daisy-chain=0A=
reaches them from link_set_all_streams_dpms_off_for_link() through=0A=
dc_commit_updates_for_stream(). On 6.13 that oopsed when the first=0A=
full update released current_state and the next loop iteration passed=0A=
the cleared pipe stream:=0A=
=0A=
  BUG: unable to handle page fault for address: 0000000000006460=0A=
  RIP: dc_stream_get_status=0A=
  Call Trace:=0A=
    update_planes_and_stream_v1=0A=
    dc_commit_updates_for_stream=0A=
    link_set_all_streams_dpms_off_for_link=0A=
    link_detect=0A=
    handle_hpd_irq_helper=0A=
=0A=
Commit 1561782686cc ("drm/amd/display: fix link_set_dpms_off=0A=
multi-display MST corner case") caches those pointers before the=0A=
loop, so the loop no longer re-reads the cleared pipe_ctx. The=0A=
helpers still oops if a caller passes NULL.=0A=
=0A=
Return NULL when stream is NULL, and skip a NULL cached entry in=0A=
the DPMS-off loop.=0A=
=0A=
Fixes: 09f609c34fc8 ("drm/amd/display: Fix driver load crash in amdgpu_dm")=
=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-by: Cursor:xai-grok-4.6=0A=
Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
---=0A=
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 14 ++++++++++++--=0A=
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c |  7 +++++++=0A=
 2 files changed, 19 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_stream.c=0A=
index 8d3aacc7b96c..e5134c103bdb 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c=0A=
@@ -267,14 +267,24 @@ struct dc_stream_state *dc_copy_stream(const struct d=
c_stream_state *stream)=0A=
 struct dc_stream_status *dc_stream_get_status(=0A=
 	struct dc_stream_state *stream)=0A=
 {=0A=
-	struct dc *dc =3D stream->ctx->dc;=0A=
+	struct dc *dc;=0A=
+=0A=
+	if (!stream)=0A=
+		return NULL;=0A=
+=0A=
+	dc =3D stream->ctx->dc;=0A=
 	return dc_state_get_stream_status(dc->current_state, stream);=0A=
 }=0A=
 =0A=
 const struct dc_stream_status *dc_stream_get_status_const(=0A=
 	const struct dc_stream_state *stream)=0A=
 {=0A=
-	struct dc *dc =3D stream->ctx->dc;=0A=
+	struct dc *dc;=0A=
+=0A=
+	if (!stream)=0A=
+		return NULL;=0A=
+=0A=
+	dc =3D stream->ctx->dc;=0A=
 	return dc_state_get_stream_status(dc->current_state, stream);=0A=
 }=0A=
 =0A=
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/=
drm/amd/display/dc/link/link_dpms.c=0A=
index 48b086d15ab0..17cb831ce8c4 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c=0A=
@@ -177,6 +177,13 @@ void link_set_all_streams_dpms_off_for_link(struct dc_=
link *link)=0A=
 		streams[i] =3D pipes[i]->stream;=0A=
 =0A=
 	for (i =3D 0; i < count; i++) {=0A=
+		/* A full update can release current_state and NULL remaining=0A=
+		 * pipe streams. MST daisy-chains have multiple streams on one=0A=
+		 * link, so skip any that disappeared mid-loop.=0A=
+		 */=0A=
+		if (!streams[i])=0A=
+			continue;=0A=
+=0A=
 		stream_update.stream =3D streams[i];=0A=
 		dc_commit_updates_for_stream(link->ctx->dc, NULL, 0,=0A=
 				streams[i], &stream_update,=0A=
-- =0A=
2.55.0=0A=
=0A=
