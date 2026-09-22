Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F014C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49DA10E727;
	Tue, 22 Sep 2026 15:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="UuIteYT3";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn19013085.outbound.protection.outlook.com
 [52.103.33.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F1D10E727;
 Tue, 22 Sep 2026 15:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHK8ahjck6EE0xQVUybMWOZimfEPN30solPn91lZNE/OQql85tG26XzxmPSiX6q34HsEt8w+7de3wYozjynx8SiGhl3XGx8UvCSiIB2MPxUo78Mepy5ZxS6xT4X7tuA1Ai+dRwj2YjFWPckixhOX2kspWcOll/FjqguevQtcAkCrovHyukKp8wzhI6ApeD+9f0020GLt9dNl8n6lnpqM9Oes+3OlCX/j5H3rJq6JE1nhkxsmbz8mm4Xd2BmwEYJ1FDPSXoVKS/nv/vRy+rTZGd01K2d5zudrVe6alzaBA+RN37QeQjo/Dk6oPzjGoodoK391Ib8QJPD5BN1SPk6ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaRE1lXOUYfcrNDNA6M1gZfSPpC+rkvXxED1JEjmEUY=;
 b=wDnOC3isO0xtmHsABA/hZmhgJLf2ANzDWxkOJbOC1+h0bKTOnb1Tygg7jg8nmqs8EfD3X9jtQ4oLrKf/1esTBLQk0aMNW4JTTg2SRyiV1DLdd+k0GEkircCemVbVw8q+WUwObtBilv1SXmiXnlRhkV4mU6Vg7yaMdL2Uaqu8sehro2radHGXw4Gm9fUHljFL8eGXM7K2pP1snGgQMzMgzAMzGwbUgCbXjYGISjRMriLRXhslXsH7sUZ9+NYLVjbuz0CdfFkICMgSD96OBhypXf/veZdsZAl9YEdOgo0Nv8mLGb7FK44rdAWepX7wRMcDdd4+w6PI+hGoqL2XJI3Klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaRE1lXOUYfcrNDNA6M1gZfSPpC+rkvXxED1JEjmEUY=;
 b=UuIteYT3VmWyJGfjdpfOYQAGXgPpjQrVCeJs29kr7Endb+TZuMK/W1OZ7GnF5SJMjYy9cn+MV3edstm6wYexK/i/1tmUToJkATuZyJnq9N0kIfKq3CP6eC/bnvFXyE8LRpjBl17lpF1OZnkt8LkP5cR6ReBwcY9MKeeRC2L2s43ODHvFIS8RlN8zWuPxbxabp7atFX6IVsDgoLIpJXDZFW9QxRe9vnHWCPga8WHqEetffARfaCTuAPVURbutCZ5tN3HkkxmbIx/Hvh/xTHmUIdVAJKEoINxRJqseN4eO5I7O/d8kZttuPSRuKV7Yq/zAl3g9ygcIXK5rISz59yJ2mQ==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by DU5PR03MB10523.eurprd03.prod.outlook.com (2603:10a6:10:525::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:58:03 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:58:03 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: Re: [PATCH 0/3] drm/amd/display: fix NULL derefs on MST HPD and
 teardown
Thread-Topic: [PATCH 0/3] drm/amd/display: fix NULL derefs on MST HPD and
 teardown
Thread-Index: AQHdSqoZls0hw0TPkUyfm1fNCkwks7bawNIX
Date: Tue, 22 Sep 2026 15:58:03 +0000
Message-ID: <DB9PR03MB73886F9E0F03042EE612BBA38A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
In-Reply-To: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|DU5PR03MB10523:EE_
x-ms-office365-filtering-correlation-id: be0322fd-e78d-4dae-3633-08df18c248d5
x-ms-exchange-slblob-mailprops: 7qh87CJt6y1mqZO6407WRLxlypE3k+ejgdMR8kH9yjpjQ9b2+P+k+4Z/fgZpbBZNIqPeTE3ON2tzJniAQjrfXtMRI7tEmkeFr0dfgFRquLyv0JHQ5JZQmBpbASXfuQS0BNtnugurwEySB6DloIaHdjOMlEuzY8zEzPITIR+XaxQZsZqKKKkuPw/4Lyy2PXgIwZXgQWfqC3r5/VhckAtPPpkLIxKKNFoffJR3+dwYTHoY2QXJ+D/F4YtYOaqZ44ADtGTZJjMA5qz0WPgeKrIGsqQx4Uv6emQFIBKFPbhM/jsW416YMK2591AjI07FBsMNnUkzUd9rKc/9DGIHke0tmABlSNLoE/vmURQ6pETnQm3oBwy71grII3YOhomg8txxcSUU8uaebJEDPxrPVBmsHfgmSePO+E6bsUu+H8GNqS0UPYRtPOqskvBif6KFdopH0glrGuBxc+KnhPmWsJAOfifjzrtWylSU5oBYqMIlIyiHPZKGF5hIbOY13mF2uxanXYwpwisy2kBHNncBoi+AZTBKX6f+EkstgtoUL/qfReFxkI+mM+zwx31WSx72RoqeH9F8oo8O+dz+8vLOpOz0vjiKhx0DDISYVVktQDmEVsmWkvCNRv9697ecXnS0QFKmOVkZA1g8pau8pdZBhQF6IW8mE/xRQZIo8YbbmLYjEXz8agbvgFSX1+M6zfpr5+CKPbAc7AmVbQs/bM8K2pLXJF5uV7xYU3BuRWDC+fbYFVRUawei/yYUdWYkBzIhe7Ft
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799012|8062599012|51005399006|12121999013|8060799015|25010399006|31061999003|37011999003|24021099003|41001999006|15030799006|15080799012|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eQwbYjHuPZsNPk3kCe3AEkcIkJ5bzCIJz3BSJFXuyT8Yfn8qr/tWBnvGJD?=
 =?iso-8859-1?Q?158mPufx8Ud8DZ30e36TPHOb5uIx2vwV91K/68TmWQzdT8LU8QFfe7syTI?=
 =?iso-8859-1?Q?f4ovSvs6mam3uuYd1fZ2cVAKZah+x6Nopogu3bCBgPKtLisAQciQlq/Vt3?=
 =?iso-8859-1?Q?xJFGy/qStnefsOIpr1vlD0GzKUBWK2szJiCgUtNKohjRUJJpOY4bRPc3rc?=
 =?iso-8859-1?Q?SCzvNA9g6bMlkbdq9an7UN++O6FLqIOffveX4oot15b/lVAOHRP0NTRid8?=
 =?iso-8859-1?Q?Oe8iNl4uXh5o+yO7lvyRSzKKWX+dhn5BkYrTKzG3+FQl9dF7ILUujYrrmt?=
 =?iso-8859-1?Q?pkrb3Bx4OSOuTv0GVnJYAr9SE+KrAWkCqNHC1dac4cC7iJp1UAGmjlolLw?=
 =?iso-8859-1?Q?kwy1KhFsFhj0jWcvS/iiTLyBnQObBWVML7InbdhP8W+NiKrqDzXgn9Iag5?=
 =?iso-8859-1?Q?jH+AATNX6/WIsi+kX9yoADrMYCG7oQM1SO+mX/LYgmfVOGHNNwZQOHWQAN?=
 =?iso-8859-1?Q?qoCKhdCo4w3SFcUGF1ywGm1EP/yjP2ijBb2pptRP7MCsw3+5qtm2SsG/xa?=
 =?iso-8859-1?Q?62aN5o5ZstGDCMi58LXw9zq036Lra+eGvU2zvWx+r3UTMWo513Al+6+k/J?=
 =?iso-8859-1?Q?dj8K5Hwo3qxaawcM8yIbRvv1QFnxoCD/XPJEgpqdFKd9TK8Awbw29nGXzg?=
 =?iso-8859-1?Q?yuet7aZe5h+omalEwi1sKFO0DivTo6qgCe13PUmsLqgoi/beUQ6O+peBaf?=
 =?iso-8859-1?Q?r/lE2Y5VfFEE6n5kZpRDm5/wMsEU6/oJzNAnr8RptMd2Dse8Fuqal/tYNO?=
 =?iso-8859-1?Q?j808CcA3dxNYiTqFV6tSTzVbaGTXgHguxaPC254Y5IGuUYD3ugYTmPIIRJ?=
 =?iso-8859-1?Q?KLZ9trPfCP8IemgyadVAK0O0w6mAanUbLHzrua0VHJ8xH+2GqKFeB4M1eV?=
 =?iso-8859-1?Q?NXH4Y2/5Ce8e9vxLI7DIeQXzD3VKE6NB7GV9Hdzyp+5aoWGGb3Zt6MyxVQ?=
 =?iso-8859-1?Q?vm+PFNIzRKLxwzi1OriQre4OaDRQPLR8GLmE6eZEksM/HJhEm21S7VYX1b?=
 =?iso-8859-1?Q?YGNEmETwM+cEmkBki6XG1BFVcBg1t4ZPaFbFicX7y7ur?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ajQIlJGorjLJ9q7voASMLCTfXadSyoBfV6caeMNDyjfhyznQBJlGO45BP4?=
 =?iso-8859-1?Q?tQt3hGTHNKqLmlp1/SO/vGJiQErPZw04+RoDn7lhq7t7d0yoQXuM7OelRD?=
 =?iso-8859-1?Q?5edelKgrm7kLCgWr8E5mrZ/H0jeU/XqXPvkxq5xr/icqyGWqydTCaDFy0+?=
 =?iso-8859-1?Q?8B9AlcKT32u0WenSEgyu8LhoU281KvF4J+9WevsOB0+ZCdplZQlTha5dUT?=
 =?iso-8859-1?Q?oFqKw/eHBQhMN8mQFxVzdK0LyVlYkZudo3lx8PmsHRHDj/wS5uoZb0nOb0?=
 =?iso-8859-1?Q?Tb1NS2MbbJuNApB12sQENw/iVN68oGC6zMliKdeeLgZ4GkxMhFj1xbtSNW?=
 =?iso-8859-1?Q?jv5NZBw6XxMFC2yTFWqAsej866ZD7hI1OcVPTw9+wYnoSfwEwkF+Bi2Scv?=
 =?iso-8859-1?Q?1KIC/6nWH43xYI+go9hPR80KXQfdaC+HUFl5+ORRMaPOFwcA/rPKPyhCHF?=
 =?iso-8859-1?Q?qp5UtNr+3ZuuGraVtDQGaN4w/qvcwucbcqkZj2XvejLWGD098nDWt8oNyC?=
 =?iso-8859-1?Q?JlTftvA5tlpaA1zXWXUMAvvgY2mmO8LWOhLBr0Qjs1Sz1ionT6WmJrtxxP?=
 =?iso-8859-1?Q?4V9HHYqQkDOXOAugRH3J+1n3OUisafd6VkQkD6Ar8GjOyPn5yR6FBQp+4P?=
 =?iso-8859-1?Q?/fSoD/jW2GB2i4wOO6ZY52YfwN235b1RrjuzUGGmAWWo5XKUUirCOaap8P?=
 =?iso-8859-1?Q?X43SuQXBRZpt6YW+lCSuc8sLKW5xu9Xcok04yuxnsMSzUL6tZBS1zOGAbU?=
 =?iso-8859-1?Q?p2ULABIxxi3M0fVYr572c7iGOwNV/3QaUdjTcxu23kx+grMbZjlSU2ZB4R?=
 =?iso-8859-1?Q?tXs88b/ofAdmmZb5hpsMV7flwX1rdo5gKvTb0kcH1CroWhZ/Fopm2bHmzI?=
 =?iso-8859-1?Q?bGRlqV277QE2LS6jArExHiJhBSkeEIW5AmE09VoMEVazUhgWbg9noL5hJ5?=
 =?iso-8859-1?Q?Mfl43Cm28kUADNjQhI1CujBqfAAmYyOYkA7SjRAKmt4EamC850GqLwlsCH?=
 =?iso-8859-1?Q?xtKhxJ2WNTLprdqzH90yu5B3+3gBNsjHkaS444w29/rLBfpLGkPPF4Eqmq?=
 =?iso-8859-1?Q?EO6VSpElDQLUR1BvzFsHzpgmWcdMffQJ2VR5r2PoTAnDBUDtO8jy5JNAFJ?=
 =?iso-8859-1?Q?JEwTj+mscudoxsnv5Qm/Y1O4pR7cOaCbF/fdOJt7b9iSghliHdhtDadN3e?=
 =?iso-8859-1?Q?xwCXSaV854Oda5bCOAOzO9yg52MgPmZOg93EinM1uSAtx5JxX8KdyOAEwW?=
 =?iso-8859-1?Q?drjAnxqpzTeiwdttw337jdNQuYyDqkaHVHrjeQEaXo5Je/gsxwHxe+JIyp?=
 =?iso-8859-1?Q?TyZPmWqVoYEhF3yA4v0hATr+DHqcLvnUnxzk1P3EV1LtRTcZpbUjxfZCAd?=
 =?iso-8859-1?Q?FRIUp6S+9J67jOjiMQuxlxaVQbvnf/HivBOKjFQ2j9WaLmjEiBNaRQDEA9?=
 =?iso-8859-1?Q?dxs1JUr7SWle8fAz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: be0322fd-e78d-4dae-3633-08df18c248d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:58:03.4241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10523
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

Sorry, the cover letter still had the placeholder text. The summary is:=0A=
=0A=
MST hotplug and topology teardown can run while the CRTCs are still=0A=
enabled. That oopses in two amdgpu paths, and a third path turns the=0A=
link off during detection.=0A=
=0A=
HPD detect of an MST daisy-chain reaches dc_stream_get_status() from=0A=
link_set_all_streams_dpms_off_for_link() with a NULL stream. The=0A=
helpers load stream->ctx with no NULL check. Return NULL when stream=0A=
is NULL, and skip a NULL entry in the DPMS-off loop.=0A=
=0A=
verify_link_capability() DPMS-offs every live stream unless the link=0A=
is embedded, training is skipped, or dpcd_caps.is_mst_capable is set.=0A=
detect_link_and_local_sink() re-reads DPCD first and can clear=0A=
is_mst_capable while the CRTCs are still on, so detect takes the=0A=
destructive path before MST rediscovery. Keep the non-destructive=0A=
verify while the link still has DPMS-on master pipes.=0A=
=0A=
dm_dp_mst_atomic_check() calls drm_dp_atomic_release_time_slots()=0A=
after an MST topology restart has cleared mst_root or the output port=0A=
connector. That is the amdgpu side of a NULL deref in the helper=0A=
during kwin_wayland atomic check. Call the helper only while=0A=
mst_root, the port, and port->connector are still present.=0A=
=0A=
The matching drm_dp_mst helper fix is sent separately to dri-devel.=0A=
=0A=
Reproduced on a Raphael iGPU (Ryzen 9 9950X) with a USB-C to=0A=
DisplayPort MST daisy-chain.=
