Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BBECA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F010F727;
	Wed,  7 Oct 2026 17:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="X2SvEDk+";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn19011031.outbound.protection.outlook.com
 [52.103.33.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E177610E2BE;
 Wed,  7 Oct 2026 17:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/nP9COykwHb4b0CjicscjovoQB7GsNTJZdGSqOOESLwWZZrKhpQWsXGee8ulPMNmfT3TTPaSL9DASa/OO8ZOToxptCs1SAYVbqoDjuq+lqYxd/KPixoUWo8Wki5vM/SXQXsEUvY8wnpRPiJujotI/0huzpVzxggW7Ui35hqCP05bR4epIZ8Qma50CG6yGyZbWaZvMyBtZKvRp6o0SmZMDQPV8VCIikGV1j1Acjb3AAN2lJIdzH0m3ocsWTv5xV/6IKm7p6XSHoU4h/Q5OfgN6jOVXsG9Wo+fhTM74o4EGYh5TT4oBwC9Sz2gdDzZR/EVCMbhFQypb9dLKaJMk0URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jej7eMwB3zFDlxc3ocCiaaWUM0AzH0Z9TkKMsYaipvY=;
 b=yShAZ3G1HMaAhDGw9NsGdHe5kT6MdQt0dx5SvjZx9xDSVMdJTdB7SBe12WHYnw7rAdz4Y61CqIz2WECdhaNleNqUL8vjoS6hjqBmXqQvlsWWOVmk7oSnxbD2Bo7C4WIunaSQKyq4fDxb9+MJfGFhwaBBKctftwlO/wKVt1mZ16sUQjgmJuRMLruREmYXs1ucFcMjLXOgG1WiDLyoEqKVwXcKiAneAanT4dkNry0KhAFImt5lCxyzRnRp7mrokur6JuIi9L9keg9GZIdK4uaXDT8nBsjjcsqGSiSc1UmVm2SZFDsAMJKwxrgZUa3ZJJCSmPN+cTRZQFpBy/KxiAME6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jej7eMwB3zFDlxc3ocCiaaWUM0AzH0Z9TkKMsYaipvY=;
 b=X2SvEDk+//aI9fTTF1z+EhXeVovW8xjTYXlbEqQB7G8wvyS8qz+Q8E9vClTrHQ6No7dr8LxNw45uUTkRfJdFrToPHk0XFx+jnluBP70sPl8WLn+g9QjgBJDEbYgtS+yjkWPzxlrEWG//yoKKO7yTjjt5hfInTxvUu51G5oDt+KdZUX6f40ocvXvmj+SyrzzbyO+zb3cS8IcEoy3JKy26ShuSfn8sWi6bZuKE3oLLT8+stt9BJsc5ICGZIQGgClOtW8cSSeUCHduQN0wlmXqvh7YWCZUfbpIm/0UyxtzMDi6vXlFw6nOcIIk5ueOPh6k/mDM/3QbuxHDIEoL5S7EnWA==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by GVXPR03MB10898.eurprd03.prod.outlook.com (2603:10a6:150:214::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:47:18 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%4]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 17:47:18 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com"
 <sunpeng.li@amd.com>, "siqueira@igalia.com" <siqueira@igalia.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: fix NULL deref when opening a closed DDC
Thread-Topic: [PATCH] drm/amd/display: fix NULL deref when opening a closed DDC
Thread-Index: AQHdVoN3m8ngRWIFC0yB4TViupGfHg==
Date: Wed, 7 Oct 2026 17:47:18 +0000
Message-ID: <DB9PR03MB73881C96FE86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|GVXPR03MB10898:EE_
x-ms-office365-filtering-correlation-id: da2f4df2-14da-4e4b-caf8-08df249b082f
x-microsoft-antispam: BCL:0;
 ARA:14566002|51005399006|41001999006|31061999003|8060799015|8062599012|19110799012|25010399006|37011999003|12121999013|5062599005|15030799006|15080799012|24021099003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dhgJkTCboJQn5U71YiyGtp7+uKeSVjKyVOamsVPnc8oG6lem0fdHFqh0Tj?=
 =?iso-8859-1?Q?fBrMFjZnyMcpzYNKvNlRMoj1zG+JvogijxP3YRM+hmsNsBK5HETFS6ms6E?=
 =?iso-8859-1?Q?enSNNlv0wiG3slI7lWHp7uomREFtuH4K0BS7plDjaPq6Ym4y8Yw3tRTWkM?=
 =?iso-8859-1?Q?rvG9AXXy/yAWwLrYRn+TB70ItG4AXFjR69/u6dRwvOyDtFvptkbXsUWTSg?=
 =?iso-8859-1?Q?EQpuUACCdZjz2ZwGfZLm2/ichdXRbJe8eLj2LO/+mb6g6GbxlhZ1uLVnWm?=
 =?iso-8859-1?Q?b+ABcIlIE05rej7ECmkA9WxRUSJg9AtTeH0zHeigr9ZwHp/Ie7/W7SQnLh?=
 =?iso-8859-1?Q?s+pScR4Lcwz5nNf/y07ts/R6mMOgu2Vcw2BWGRIHT5D0Wl7KXK7Rr7V5X8?=
 =?iso-8859-1?Q?rOLa+BO/irka2HtgrZc+DH/6qRS/2hNyPe+Fa6IMw+M7jdxcq7TdlBF60i?=
 =?iso-8859-1?Q?+N/A9p1I3wjFsAdLJLC51gO4uQU0pmW0r/gTrIYH09eX4QdWXsozJce+Ji?=
 =?iso-8859-1?Q?FIzjQxJriv7t07tZSaD6VSSMUm+k1Ez0h9N977NeFFjvqg9Yn+gt3UX3kJ?=
 =?iso-8859-1?Q?viXeqFocnfiy9fqlYpT8Mw9VwRtOQkm5ZYVWbKOhc5jOjO7OfE3fDCCa5u?=
 =?iso-8859-1?Q?urPWMoF7jWuVA1/4K4SD4u8icwu1I1TzfBo86yi+V4z9+aH+bvAQGcFDI1?=
 =?iso-8859-1?Q?QP67Uxgusqu+zpew/U7goeJfysuJpnhahoXPWUMka0AqAb0rVbXDPxY8cO?=
 =?iso-8859-1?Q?aUitx6U/+flQSMLktZtKP4Arl2TzAz8z0YDlucxRskv4bEYPkLY99njr8v?=
 =?iso-8859-1?Q?xvJ6QgVRbU83TAWjmuwT8DPU6lM5W/1/hfKi5b4s/lG44tCF19fI3ZnfHx?=
 =?iso-8859-1?Q?5RZvEPvTs0glMex+mfQ2l131MemQugos/QAhgzpFyf+Yi3X/YZtiKZ8RSG?=
 =?iso-8859-1?Q?Qg/ivK9t9kZZXue1foyOC57GdYIYU3rAU6SBAmqEXbA//LaFLJzNqVovRl?=
 =?iso-8859-1?Q?ocJpv9XHskfdL1thQNs5GK9NGgoj6gh7uIw3QrZ4C7hg3OnKEnFmQOGpEb?=
 =?iso-8859-1?Q?bYpjWofAfBXAB0mkYTFWoO9xqq0fY8gE9QMcHGqKAkWQ0SYWDnARucdLip?=
 =?iso-8859-1?Q?hrET8FjQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M1vZx84Dtt/gyJYOmxi310TiEhcP4yE1a6D7YuBHwJkQxDiCYO5O/sXc8D?=
 =?iso-8859-1?Q?X63uk9ylthOMIbSsYl4zFOUiw2z3gHDq43dIJSRmHyWMkfVy4TpjugliNQ?=
 =?iso-8859-1?Q?BNd+9oxhSJBc+dIYY8qlRKdTUE1SdKDn6ZJMx5/UVKsCK2q7kzaCe1YFTk?=
 =?iso-8859-1?Q?yDX9h69I7wXwpC7SMwGFLNKtW1BsvvBFuaR1i+dGifm+znGoXr9JmH/SCY?=
 =?iso-8859-1?Q?8fz1hd9XsNw2FV3fzTNVu68wokO0ndniQHv39Jhm6qLokhRT2nHWk1zSkE?=
 =?iso-8859-1?Q?wHdv6jBqp7eCfTwIKzGgEYsfj84GSY7KaOndSaJ6hLFdwbyp/kbvhdOukY?=
 =?iso-8859-1?Q?iD1qJ4kZC/DOtqBuXi+nh5LSkeeB+FK2WJgxLT4PpAMLYiJ2gssNH46J5X?=
 =?iso-8859-1?Q?v6aw1/+9ZJfUn4TeepHqIXxPK/+qWgBT6wi6jSyfODZA92P+g8qFRIhELM?=
 =?iso-8859-1?Q?HksbznMwB52DnuDTzT2UIrFEc0ExtbSWXCrR/x30gzLNtUx+PcbfaCTlFF?=
 =?iso-8859-1?Q?9tAQXSTG1FASrI4FWAuXlcbokKLBxjxI4yMS9QQMUdKBjGSHk65vIcAPLi?=
 =?iso-8859-1?Q?g8xtiTPl5WbhbF3LaK3xSjamp5xO0uOoDSb5fOQg497FD6V7sTzwwsxnfk?=
 =?iso-8859-1?Q?vpB02LrRUHv7wrzRUiiJ1cFmDpRCeWQ50j0YU9+BOagC8S5EgV3n0QUHhG?=
 =?iso-8859-1?Q?H4/zBBLvYHZ95BaeFy3X7h5J5gpzkEsx9Hs96bXnVseXcDQwRgsw2f2WdV?=
 =?iso-8859-1?Q?aCFcHl/iotd0K2GtMxg0cIQq40FnN3iWvS9gmtcFuYu+dCfTyPbhfJnbNa?=
 =?iso-8859-1?Q?uNlqVGx44tUBXSkHC/4d7+4SaBk8/X0N4CVhaKC6JOl51IZnxd6AAqTaEA?=
 =?iso-8859-1?Q?4KhVgLhJuehoPH7qSEeF24G7UyMiE8oSC86wfVaomhG9ZqwiMlY3xH8s4L?=
 =?iso-8859-1?Q?Fzx7pJcxhEHzLIRQYEVqVjwhii0Vl5EOwNqBCRx4/9Cj4MwJ8OmOtKGs4Q?=
 =?iso-8859-1?Q?IV6/p2ZggiPcov/0yaZUNW683FWRM1DCK0TO8xLbKRRE6+hULIwT8L66xW?=
 =?iso-8859-1?Q?TenTvyn7JtC7sd2Sq3fxRKLoohVPPH1n33+ux1NHpbZicf01FnoHIwg5+o?=
 =?iso-8859-1?Q?oxa/mJTtFyKy5q5z2MVkyoJSAQYsSpvRDwNO2k5Dy6BipHSSzDKgMx4ykT?=
 =?iso-8859-1?Q?t68Zm6Nung5Q45wNtZ1J4+gSCMM6TWVfcVGMHleUZ6KDqbf6d3AwyNWIGn?=
 =?iso-8859-1?Q?VvBXsyIDJw50sTI626fUVTJRxDAFIKf3h3qeKTRPsUM24Z1eKTsepiV9xd?=
 =?iso-8859-1?Q?/bKKqI2r2/MRUXwdk1R1nASEris33qaVRFix/e8GkYp1tqPy/QjrbQ7bFB?=
 =?iso-8859-1?Q?L+5QQoQM0w3ZUgZZE2+l7uTEc2gksA0qJLSInAohFJ9LRaWxIBE678yxeb?=
 =?iso-8859-1?Q?aytcqFgJJ8VXiLqb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: da2f4df2-14da-4e4b-caf8-08df249b082f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 17:47:18.5171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10898
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

dal_ddc_open() uses gpio->pin after dal_gpio_service_open() installs=0A=
it. Close clears that pointer. HPD sink detection and a KWin atomic=0A=
check can both open the same DDC: the check reads DPCD for DSC while=0A=
the HPD worker closes the pin. The load of hw_gpio.store.en then=0A=
oopses at offset 0x28 and kwin_wayland exits with IRQs disabled.=0A=
=0A=
If either pin is gone after open, close what this call holds and=0A=
return GPIO_RESULT_NULL_HANDLE so the AUX transfer fails instead.=0A=
This does not serialize the two threads.=0A=
=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-by: Cursor:xai-grok-4.7=0A=
Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
---=0A=
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 11 +++++++++++=0A=
 1 file changed, 11 insertions(+)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/g=
pu/drm/amd/display/dc/gpio/gpio_service.c=0A=
index 95f8b7c7d657..a3145cd82d8b 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c=0A=
@@ -577,6 +577,17 @@ enum gpio_result dal_ddc_open(=0A=
 		goto failure;=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * dal_gpio_service_open() installs gpio->pin, and close clears it.=0A=
+	 * MST bring-up can AUX-read for DSC while HPD teardown closes the=0A=
+	 * same DDC. pin is NULL again in that window; do not dereference it.=0A=
+	 */=0A=
+	if (!ddc->pin_data->pin || !ddc->pin_clock->pin) {=0A=
+		dal_gpio_close(ddc->pin_clock);=0A=
+		dal_gpio_close(ddc->pin_data);=0A=
+		return GPIO_RESULT_NULL_HANDLE;=0A=
+	}=0A=
+=0A=
 	/* DDC clock and data pins should belong=0A=
 	 * to the same DDC block id,=0A=
 	 * we use the data pin to set the pad mode. */=0A=
=0A=
base-commit: 41505ac433cc4c5179deee8860d197b04f6d1c1d=0A=
-- =0A=
2.55.0=0A=
=0A=
