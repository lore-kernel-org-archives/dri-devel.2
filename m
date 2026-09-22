Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB539C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0184B10ED9A;
	Tue, 22 Sep 2026 15:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="rZKgvEcc";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn19013072.outbound.protection.outlook.com
 [52.103.35.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358A610ED93;
 Tue, 22 Sep 2026 15:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNwCZ/kGeLCsAwS2k3u/B2ividZPDos+8PVhnRgyjfxVsBo+jYcpKg1Vvp07+enCHDpPaBu335cxV+h66PKYG/lsmzwYH2wBw97O3nJqSYy/WI61FZnatCwDviYU68WIQf3Sm0JXfJGtcosES7yOLM5FEjPBMMpvLY6RGpZB70ORHTjS4vHVppFGoCHqExbdGHIZjnM7NrbmCxg3S+zIi6wX1zFkQm5hoLp+kH55io+uK5flcEJiyP3oVri3JNLHvzdnIdarYmoCw74hkYnQFt4zoLFXPK/nChbBgFuI/YfX99KTx/amWutgnSgt/QsAEHPaMbVjzSLQDbSb+SHcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGFMBZxIWTyWbJIkjDnilUxKpd06oUG1l1AOQKBUYdc=;
 b=ERgG0LvDpY+1eXlmrbfpVsxBSXHOGR3SnZwcOyKOGoNWgYfiybgxFEUJeiDi+rFqm9wZCD/mwsxAmFDiQA0mqUhoNNKUX5E7Lfsv6DVanlVJudC7e9I5/RP5IVHf5JPrEOjk3UfgpFti/YBZ6uGka7wBwBhAoG6fK7OlTqyHL4yshrLx33jlUE2KknhAGhUfS/U/7bYknxfY02OyX2neLgwM2TgZOL7Yfl+V9Brgol4eIdP3dm9cJJp9cyojTAQ8seUdYxdyFqFVVpk/Vc4gzZ+RrZdzJX7jDHZ5wA06p01K5u4iZ/Q+Cuay9Qz5SB48/SSJpjy0TiR/YBKkQqhKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGFMBZxIWTyWbJIkjDnilUxKpd06oUG1l1AOQKBUYdc=;
 b=rZKgvEcc+KHBSab1lLz+BDmjj4upsm9y0KBB05stIls7CRhOrpu8RZ587lmX2n3XIIkCSw/bHfrlHq5BJIpjbs6cmrHol0bdBuQ3sbm8F6q4Ow/Z4pL7MGinIGzkyRn0OnTdU/ez4h6BDitGpbckqwDdgMMzd6Kl/K7s18FGdhHXtqHWzDUqNziqE7l7bWAF/79Mg4EfHVyvepW5Cn1dHZaRWqBk9x42Gi3o//LRuHmgLkDH5bEQNjpq3YDkP0FSZJefcwG9OK2DVPDhLoG+nsIGYvf0bqn+c/P+IHj95O51XwRy+jp6aKjt8uYgrhVZQGcxOUCkJCaK3E3q166e8g==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by DU0PR03MB8743.eurprd03.prod.outlook.com (2603:10a6:10:3ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:54:10 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:54:10 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: [PATCH 3/3] drm/amd/display: skip MST slot release if port is gone
Thread-Topic: [PATCH 3/3] drm/amd/display: skip MST slot release if port is
 gone
Thread-Index: AQHdSqqbLclsSLlyz0mvuugI7q2wIw==
Date: Tue, 22 Sep 2026 15:54:10 +0000
Message-ID: <DB9PR03MB738847DBD9FD20EAFCC948BD8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
References: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
 <DB9PR03MB7388900446938D7712613C9A8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
 <DB9PR03MB7388AD5607A0A66DF2D477EB8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
In-Reply-To: <DB9PR03MB7388AD5607A0A66DF2D477EB8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: de39d5e4-31dc-4827-6851-08df18c1bdbe
x-ms-exchange-slblob-mailprops: 7qh87CJt6y1mqZO6407WRLxlypE3k+ejSB6jDffLzJzymJKEFZqSOfETn4nSYipytc5L5EZgR7pRNIPXIMHBhI5y4eEYpgWeehRhfKKq0UPHpLlj9rVk2a5dxovfhcAUQTZKUrRJAIuZv1Hs9Y9ZRMjxOfWiJrPODOVb3oMP7Nx07IMV1L8XgIMX1bP1XDNWwVmm99CQ4cPr8zDCNhTZa/VjaMN4Yy10FlSCM9d8LVeqxuNyI+QBfpHvntumoV+zb2Y+z8KIIZ1TOaZEOpuoIyPC2lap2DnJsCgub1puL2Gwtw0DwuC9dA6SN5pQKaZTiMlqWcOMQwixAjCnX9F3XhjLGRrcwoa9nNP2LOFW1XtS+rOa2KkalVn5zl4YwzUYx1nYTOVCUtrm9LhWuhjA41X8r1XJAJApvWlmQXdG0YaXnpZrlKar0YkAZbGbEOm8BPBBGPni3iTynDjJekH4Ctk5Zj6ULiWNV/n6SncBWROGGwWjFBxkP/3oRZ7pOZ6K8/mPrOAVZp5vmBI5wT/0dlK/1EZa9Ijn6gHFmJl8mt+X5oW2YT7nFBOTeZtlddSGB6/QvfCU011HUj0DjMWvMAvcuCtSGmPCtH1DZ/2QCMzNuEmzfQ0ptA1Gpo5+p0rwri+oqI2v/Tb5GLUKBY2zUEXtxLAdW1PaJbNz6sed4sFyO488qKfAWpHMonsGQNMwX28zLRhhs/TYlNZsBeJFkzud7uDcWir6c1gkt61+VS6efsXBDqpE0le8TUmmd11b
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|19110799012|12121999013|8060799015|51005399006|25010399006|15080799012|37011999003|31061999003|15030799006|41001999006|24021099003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bZe5x/88FvAnGWRyyjx6BofZquTWZLNcSXW6r8e0zoSCByQAoWnvvsDixf?=
 =?iso-8859-1?Q?ORW47pUydP/13zZGMtgGepaA1SbWy7avQOBrqGt7Ko1H/YoagZQyY7+urq?=
 =?iso-8859-1?Q?4O8XNMOJnMNolDydAU5Mk5QIGeWoLiglec3jsnUD2QKLkJ7L4jINJBR/q8?=
 =?iso-8859-1?Q?XsfIuft74M5FEyw2zwrYJkFgqX5I55DoNtqAmP4qsXjBJkvxkJHuFnW7Ry?=
 =?iso-8859-1?Q?kkuCSFjSz4ef1UXaz9Mb0bH9SUXwY+3uwrd4cqaHOdmC/WyXexFPtczqi2?=
 =?iso-8859-1?Q?hWNQQ3XeTUcxcLFOlVPe1Ob5K4D1gwEzKA/C5XxYN00TOFjSrmcoLMlEHI?=
 =?iso-8859-1?Q?7d1De+YlSwn62MYBPblR8XSalCrddrkor5i33VOONUaEauOTJth0t9l1vk?=
 =?iso-8859-1?Q?u/LrsxmpUopEVuAHVA0nwrZBbTeGf/3lKYHe1+Xr+YS6+5BmYgYU2oauJp?=
 =?iso-8859-1?Q?k3FhgzUTIUA4PkyT1FjB5RS8n64eDT1H1Jtm9gSxpvLu07TrFIxHkvsQmi?=
 =?iso-8859-1?Q?Omj1ZX18pfPlyir0YDNQhtdUg2b4XqdDpGQ4sA2RnsH+1uGKKEx3WXM+uF?=
 =?iso-8859-1?Q?R3ELkmB+jmo2iDU+WjRtrO024/16GwSJE0WVkQsGHckUztoCUd97XMtHv1?=
 =?iso-8859-1?Q?rRiMplaBM+9+su/+LkDdNS2zbwS+vZb1aF0p6lzsBWzvED760P+jnvc8Pq?=
 =?iso-8859-1?Q?AxK6tzPwui06q8L4WUXbGETslQOlZJ3+XayZ5nG3zIz+EAwKjPw+Fp3OWn?=
 =?iso-8859-1?Q?Nty1kXXoamy1rHuy2NLATVV6pVmF84JE3vbR9t9LbW6ADqvIH063KTXDdh?=
 =?iso-8859-1?Q?+EoXF88pwzaqCBTE85qvIAb+X9bpUoSZw6kg9etFpls+57FHo3lPb/X905?=
 =?iso-8859-1?Q?rLw7hoekOoNxtbOg6GvJoE5M5zUFvMD9DCW04EBJJ4D3fNjhQ3lN6TEZEg?=
 =?iso-8859-1?Q?aiDNCinR4K9Hk0Xv7AcrLQv4/fXj7s3u/UFA1HLPlkXCn3qA4AvECkkAWR?=
 =?iso-8859-1?Q?923A8bdz7YRn/ZWzwkA6wMVFRqr+bjeJ99QplUXtLBTYuvxl4tpS8OkDYn?=
 =?iso-8859-1?Q?B2QhS7cpS+1Kal73xU1W9BZTaumbHRsLZ2NclCg72nCF?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RlFXol7iTCRPJHtC6erD1gOZLLtKTyc4hgJ9kyceRew1ou0HlTJzKMCQLU?=
 =?iso-8859-1?Q?/QrS6T2KQZXx9OaBr7Anv6UXvKwRdklVrH2T7FqCBentgmCIcTJcD0fR/T?=
 =?iso-8859-1?Q?OcXVnhwU64R7YEOIr4HhOGdr8vZ6BG54f1GsovqnqkIgX2ejXjv0SAZdLG?=
 =?iso-8859-1?Q?LHHPg9FN9S3Qt4D8EbeR/h4IkHf2gVBkCDK1cNA3oPuWsR40yaZPekXQ1e?=
 =?iso-8859-1?Q?eMinYQFYHZSi7guY+CK6CugxJ78X7WtlYj3K6ePx6p67kaLBMlTAki8XWI?=
 =?iso-8859-1?Q?8hs/y9ios2jX+LCdCCvBy1jM5oU/+AwZ99DehdhziRglvMo3XxGBRh2rG5?=
 =?iso-8859-1?Q?dG9h4r8W7xfOmYFyYASPp498MkX4U1t3C3a5ah8J46B+rBp9BMXMKQnGGB?=
 =?iso-8859-1?Q?wRxWNiq5g3SzbhIa64PmUMIYlO9U9gQXKcWE+BM0Tg5+QYD2POLzkGP4BX?=
 =?iso-8859-1?Q?n/DzGeZwmdomCTMSnjDLLRvpIBAqtGyLoE0CvLiHulDfWQbhBx45r8Lc/h?=
 =?iso-8859-1?Q?F9yCQmvKmfNoHlHzUPQhtFgtC3rDd2HtA5vuM2lx6tiYYvPxL/l2Fq9t6b?=
 =?iso-8859-1?Q?njndoqH2ugEH8mJqERElmpIZK0qpa7neNC8Cr4xlgBAlnwROSbnDaYAuyS?=
 =?iso-8859-1?Q?C6+YzJCechq+AQ8q/kyvUbPq5LE+HmcC6sq6uwSo6AgIF1BGSoghnw2Ykj?=
 =?iso-8859-1?Q?EUohRkHlr2+XSpgmQDK/75y3lGBztYrbVrUN6QExBz4ktorV7OhDUp7O+L?=
 =?iso-8859-1?Q?xB4dUfY2rCBSwiRHXksBqDaHynhwF9nwWXpDdit/R9OuQaRaA1zpxx5+2s?=
 =?iso-8859-1?Q?bpRbPWISUZFvXE2zdy63r5+Tf92ODiCQUpeuXI1bisMtIXPiX1qzDiF0Gu?=
 =?iso-8859-1?Q?fRWfMlhwrpCQJtBBnZSeXzrzgVyBoq6aE5kbXBYQ4ZpakBFvyEdesBJ09g?=
 =?iso-8859-1?Q?taMvuDHxpsM2HTsw5ipJrzWCSAPcaWLM5XRI5YiJLX3kapps/hEAQHHn9q?=
 =?iso-8859-1?Q?7HMYkUcF13P0F3t5VvcbAe4STi2L0+7YEmM50CD5V+41Mzp9F3Ysr+TrhW?=
 =?iso-8859-1?Q?EnNF8eOxSgiXeKkze4qlwjYH8cZWRPXBTNGGYTJokbvXPIiWxVaDVn0I8X?=
 =?iso-8859-1?Q?LEQqQ3dHbMQ0v0dRNciuAfOHjN2iFd6Mz9KqQo1qXeyvG8zgPkiADjW5Sm?=
 =?iso-8859-1?Q?wkN6Gtmmkn+SrPaL7U57oZR0fUw9Bqye0v8r7V5oiPsfp6dt7Cbh3iq2pD?=
 =?iso-8859-1?Q?ppMZS0de5nSsCNGVZ1SviP2i7AguOBAFQoIfh/wao89kS1a5fFf57jv5o2?=
 =?iso-8859-1?Q?KWJRMC2l4U47pzAaziYR5zGLpRn0lsRidfrwtc5lvZ6dWuvcK1zgvHwuEX?=
 =?iso-8859-1?Q?wlacLqFcpOKQMC1SF8Ti7IkDVP9U8O/IU7t+KouIx0Tp9+ruIbaP5pAh+r?=
 =?iso-8859-1?Q?/VHptZPPV4y9PzGW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: de39d5e4-31dc-4827-6851-08df18c1bdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:54:10.0798 (UTC)
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

From b554858dc4f2c48be0d44e3c66ed781842365bd1 Mon Sep 17 00:00:00 2001=0A=
Message-ID: <b554858dc4f2c48be0d44e3c66ed781842365bd1.1790083445.git.arthur=
_liberman@hotmail.com>=0A=
In-Reply-To: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
References: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
From: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
Date: Mon, 21 Sep 2026 16:36:52 +0300=0A=
Subject: [PATCH 3/3] drm/amd/display: skip MST slot release if port is gone=
=0A=
=0A=
dm_dp_mst_atomic_check() always called=0A=
drm_dp_atomic_release_time_slots() even when mst_root or the output=0A=
port connector was already cleared after an MST topology restart.=0A=
That is the amdgpu side of the kwin_wayland NULL deref in the helper.=0A=
=0A=
Do not call the helper unless mst_root, the port, and port->connector=0A=
are still present.=0A=
=0A=
Fixes: 3261e013c0ca ("drm/amd/display: Add MST atomic routines")=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-by: Cursor:xai-grok-4.6=0A=
Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
---=0A=
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++++-=0A=
 1 file changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c=0A=
index a5b15bef8aa0..104b874b6ef6 100644=0A=
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c=0A=
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c=0A=
@@ -614,9 +614,13 @@ STATIC_IFN_KUNIT int dm_dp_mst_atomic_check(struct drm=
_connector *connector,=0A=
 					    struct drm_atomic_commit *state)=0A=
 {=0A=
 	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connect=
or);=0A=
-	struct drm_dp_mst_topology_mgr *mst_mgr =3D &aconnector->mst_root->mst_mg=
r;=0A=
+	struct drm_dp_mst_topology_mgr *mst_mgr;=0A=
 	struct drm_dp_mst_port *mst_port =3D aconnector->mst_output_port;=0A=
 =0A=
+	if (!aconnector->mst_root || !mst_port || !mst_port->connector)=0A=
+		return 0;=0A=
+=0A=
+	mst_mgr =3D &aconnector->mst_root->mst_mgr;=0A=
 	return drm_dp_atomic_release_time_slots(state, mst_mgr, mst_port);=0A=
 }=0A=
 EXPORT_IF_KUNIT(dm_dp_mst_atomic_check);=0A=
-- =0A=
2.55.0=0A=
=0A=
