Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44042CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F23A10FF0C;
	Fri,  9 Oct 2026 07:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="SKcKWJIz";
	dkim-atps=neutral
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com
 [52.103.73.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1650010FDA6;
 Thu,  8 Oct 2026 22:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz6ZUyHCnLFnS9UTzXH8b8gib3wZ2iI+NK2lAaXJ5KaE34uWZ5V+4xMiRg0lvYJlU55d1dmvaz5JWBRE9BVDZUSb7O8PHK84EBzR3twl6G6xVSRVgxYo/YZyY9ttt3hlAI0quP4jg3dEvoCNrjhqAEB0SvHZZq76vCIKwQQZ58SekwORG4yYAG5JkCc4fDlL1yzjKEA0F+lIqBw8lBeRNRrnfmiwqiIGmOjbzc5Tot+MwXjDF1QT4zLx1dbK4uupbxtX3VlAG3qsGiZFBF15NAP7A7GaN9gfId/VWx2yjozNb/M9EeMHniNTcz6YM8BTF7ewIlO/jFp4vBUnZJf3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIkdTef33D+UeU9f2VZyNomF5TP+8KexJI+5ofZQK3I=;
 b=kSa2oi10TXMtVy6FvE1CtmHpnlsfL1yrpT3+Wu3nvT2ftq6HLwRLjuGkCSZgaBttcoX9OzV++gv2PMF3MCvArn3QI/y8PFy4NsXQwmsnqpQEQFsLGWjCyvp6tFFzrlkYsp3/tbuZejOD+X5mccA1WNNQDx5lwi3T1N2uExoZZbiU1VeKb/JAg/mBMDfLrI4eDhYeAOQFvTQZK8WhPTTLAjZM9r4a85RC9K2zgq5pL1z19H4qywQDtMQsHKLG4seOjGEZU51OSzqvXQ0UQBERDUMTvostW9PLQjExx1zbJ3QBfYiBqj/lOLUr+r96eRZRaauQigsQUw/YT1SskkXMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIkdTef33D+UeU9f2VZyNomF5TP+8KexJI+5ofZQK3I=;
 b=SKcKWJIzislWWFbxX3qD2cfTomO6eKhm5FeeUNiyr3i8GJpFXut77U6mKloFvoiFLE06xV/mipIYOoJPleCZeCEkVK7W85AA3ZSUnhUajpmInKydancHPZ3EKx1+0m4wbyDknbWx1jU+Uuu6JkMNKp+2AiqRvAYp1HH9vKHPpoMR8MWJs2bI/JIeLQCCTxfOBcvpLO1lbAZya1T2Wo1j6gt9/SJJAkJM3ftkpucFhek0lzgBpZPXzczTdouAf8O0AD/GOKSIg+Nzlzo3PG7UzaCzfkSrKU1mBae/bVHWhMSLM5c/iMvQx2Lz9f87Tr6lM79zVoHRdint8leU71/RAA==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY3PPF346C5784E.ausprd01.prod.outlook.com (2603:10c6:18::40d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 22:34:52 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 22:34:52 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>
CC: Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/3] drm/msm/dpu: reject video scanout timestamps in
 command mode
Thread-Topic: [RFC PATCH 3/3] drm/msm/dpu: reject video scanout timestamps in
 command mode
Thread-Index: AQHdV3U7n3REWdlu506FkvpR7BjP5Q==
Date: Thu, 8 Oct 2026 22:34:51 +0000
Message-ID: <SY5PR01MB1060081221E28F78CE120FE4AA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY3PPF346C5784E:EE_
x-ms-office365-filtering-correlation-id: c5314f85-5c83-413a-a450-08df258c5ec7
x-microsoft-antispam: BCL:0;
 ARA:14566002|51005399006|8062599012|19110799012|31061999003|8060799015|25010399006|25031999004|12121999013|704163111799003|15080799012|41001999006|2604032031799003|38102599003|24021099003|16051099003|102099032|2607281247196008|440099028|26104999009|3412199025|40105399003;
x-microsoft-antispam-message-info: =?us-ascii?Q?83S7mBYCyy/zUIHRmLHOdpqEK1JUm8l1b0Mrp80Jp8k5yvO64hEOViHSw/bf?=
 =?us-ascii?Q?LTpanYWrx8SkHUCEYmzFLX2Vt9nD2vczR35N+NeOdzyXMC8AEysh+MX3wmk6?=
 =?us-ascii?Q?vX+/pDd6B8LOcXWU3xwT0kJHFjOXiqtSc/aMo0rGMpyUjVWhf7q2e3NBEVq0?=
 =?us-ascii?Q?crNvTC8p+nZIe0sq3ciGW9fak+bHMhhGPlpxnX11ExT65VELyYhECsZHyW6I?=
 =?us-ascii?Q?R5S17QutFM2kgjMctfqmHhMm9mTSLIsLb4JNErHMSYz9y/KappGWHeQo3z+M?=
 =?us-ascii?Q?aHbsvXh8ZhfKdtT0kZfxdZU2pjpTOx2wTnLhfDWuw1xVvHVyMNHA+YIZnuCZ?=
 =?us-ascii?Q?2524nhJDfvg6SrT4RU74QbXLl6zilPI98JY+uxI64Ffr7nP0euY3PI15wBJX?=
 =?us-ascii?Q?HvxAwaBpNtpxhQWj00UreQzRS63jZGJfPUwiBSEGomSZIfEI9eRMEgC7wIvP?=
 =?us-ascii?Q?wbsc0bKSjdVgKJIig3H6Ag6I7c6HDqGXQH91fugjd8vB290ObMNMdbIBMQMJ?=
 =?us-ascii?Q?vBwNnciDKnsNdmKa5kpNMocNeOqKTkYJFkqGQr/wBBhZFENSqXK+/u69MThW?=
 =?us-ascii?Q?Gyo8u7/qv14FS6yJG0viBheCELo/KvR0vHeuQ4UsgHvFGls8FDZ4Kn5a/ESH?=
 =?us-ascii?Q?GYhEW+p/61d8Wt5L5i21igguBG8YJwRr6a3zwXxel4cdTHptcwbXTQx5byQA?=
 =?us-ascii?Q?9Jp5Tj117q3bDEzkthK48J/jo1KigPUb859pWH9GIgygKkl+n82iQcsayK8s?=
 =?us-ascii?Q?LzvGRRVCDeZK8XNGQIW8YIhaZsO45ffVd3K68XXcRw1nAQtlc3/tFv7oGCJr?=
 =?us-ascii?Q?YBqj0XV7RUVfMyfWnplSlv9JPwfrjumqqVT8EeZkFYZsPJMnLbVvkakwY4VI?=
 =?us-ascii?Q?2bN4fSIgkyuj92uH11J9YKsugyqDM4/i+cPjacNxYHICav+XnRkqO0N7Vw8x?=
 =?us-ascii?Q?VqNJ4xqIdPauWnA+ePAcgu4m0TVIjxMPBMez8Ku+Qg6VMfkcBqOFHZYmRZ0Z?=
 =?us-ascii?Q?0X154PSVeihi3aGw4aOrnMJNoXw6gi4e4evZ2uXeLz0a207V+lN/4t4I1wNM?=
 =?us-ascii?Q?Q9SsVi+YNuQTVF3Kasr5gNhtdWwa+OpRZsaSeDOqb8dwQ3UvCBkovD09jLZA?=
 =?us-ascii?Q?yjj/HN2mT6TpOxOFzED+Fd0DXVJs32UXU5s7RuPwXV0/v2n0zwgKjOtSw9ue?=
 =?us-ascii?Q?GbYY35MFZlxIkzW7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wAFPB2J6DNG0d49oGL07CcoIdh/luYI3zxRoY7NDigBsnwx6aY3Xq9aIJMEM?=
 =?us-ascii?Q?CLr5X+GN65AKPZaRS1szlDenI3ClFfxB6EboBoB9d3rl3OOpKqaK4tV5sdHD?=
 =?us-ascii?Q?JwNpO5wKthx44NMTZMik5wQRuQ9ZiG4vqwUTxGTVmv3rI1JQNkAMtjFqvqBF?=
 =?us-ascii?Q?s2pJkrbzHoI0zx2ggbcCbZ5zmoaRd4ACQ8I2PjeD4jBVANgnsOnM5IGibUWk?=
 =?us-ascii?Q?O2BZXgntQq5cWxKKCLYSFlmUaGify2jfC9cXGdOp3Y3bygJXHaqtusq22nB+?=
 =?us-ascii?Q?7oVaAhu2YEPVygmVghGMh/AmySVfKQapl84ZD6qVbs/7P1slWI/r8qwYO2KB?=
 =?us-ascii?Q?fIU/sibby761m24+bYWH9dqAmzJ/BpOchKCGN51SFji5eHtp2845mjAjb7bo?=
 =?us-ascii?Q?U/cILp7yl+BvOscN4MZdaqANDbiGMv0OzeL0NMmEyIrYA4M/QdkfyvAR8Rdx?=
 =?us-ascii?Q?DlA5RlnWqx8K2cga9s3E8mJRg509OYTR97AsM/wWgUBg2MNvrfHjT6d9Eqq0?=
 =?us-ascii?Q?Ij4sIm8gauGUUCAiNLdpPgC+hu1WzrwCwdX377pNSL2FwA+OgjaQ9EZLhlZd?=
 =?us-ascii?Q?4jpaq06ZLTQqt9S3tmgQWiDLzzK8YyI+Yotm0Jdb5/eLYf3HwvnhzvHWXkjH?=
 =?us-ascii?Q?OtFhPURxwJNV8cNwdC3RQCCvv5WQzTdJnwDj4UPBZwksHTkmIDEbebNJAh1R?=
 =?us-ascii?Q?j/+/7+In/GASkcJl1YcO5i/mOSeLWvSvx95u8a4e8ObO0VO/u6DKnI+Y7p6i?=
 =?us-ascii?Q?ObuIYyktyR1JhLlp5lvsj3xqzHQrwa9Wrg2an5iWzCYrog0N79fQLfij1s6A?=
 =?us-ascii?Q?YprWeK7E2kyZ2s5lFGKDaMbuQNRxMqN3ZlC/dcE/w1m2iekzfdxXuyoaiRf8?=
 =?us-ascii?Q?KYlkO72OLHrcdh4duvm29sHxJvRmG4ZbV9cWXRQZ4dZ/2yAaKQJPhmgZ4217?=
 =?us-ascii?Q?l3rbd6fHRbUBR5AB1jxwhuMX7WIF1kKOgDxCDyx5lAkyJ4+mijjQ4xsSmhLN?=
 =?us-ascii?Q?zzHKaaEzxKoke08JUV9vGnmEMgqim4xFWuPOBgTzXLf0qCQu2/zUdrs2CCQQ?=
 =?us-ascii?Q?UxcEwusXxzawjI0xCfe4ytE1JRZ0QrF87324a8yAUvpD5iHT3UtBS41LX8Dk?=
 =?us-ascii?Q?vxlfxzqfWBjLt5on5ocElJ8H+7gRI0Pqa8fwdbqEov/1SGwIdoS8D8LgvOyo?=
 =?us-ascii?Q?BnzsFNVaGkjxm0BRYgnaUyOJpHIcSL9G+uQcyEy2y9CN6dU/6IE2PdBwfDq9?=
 =?us-ascii?Q?zLSYx3WGlVTeMp8bbNS564F/xE8YV5mxbpSjXiFaALGDow0a4HXAo3w2zYju?=
 =?us-ascii?Q?ZkY2D/NgWC7fdyfA9+xV8yk7/q6Rb9JNrMiZwSgRI+JoqEidPTfleao2im1L?=
 =?us-ascii?Q?FdvTe3MJnWTT4u+cdz2So0eBMPUv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c5314f85-5c83-413a-a450-08df258c5ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 22:34:51.9185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF346C5784E
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

From: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
The shared scanout-position callback subtracts the video VSYNC/porch=0A=
window from an encoder line counter. Command mode uses the tear-check=0A=
counter: dpu_encoder_phys_cmd_tearcheck_config initializes it at vdisplay,=
=0A=
sets RD_PTR at vdisplay + 1, and permits a wrap at twice vtotal when a TE=
=0A=
edge is missed. Those values are not the video raster/blanking coordinate=
=0A=
system expected by this conversion.=0A=
=0A=
Return false for command mode so the DRM vblank timestamp helper reports=0A=
that this accurate scanout-derived timestamp is unavailable. Video mode=0A=
keeps its existing calculation; the command-mode TE interrupt callback and=
=0A=
hardware vblank counting remain in place.=0A=
=0A=
IRQ reference accounting and the existing off-delay policy are unchanged.=
=0A=
Idle-power behavior is outside this timestamp correction.=0A=
=0A=
Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
---=0A=
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm=
/disp/dpu1/dpu_crtc.c=0A=
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c=0A=
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c=0A=
@@ -282,6 +282,10 @@=0A=
 		DRM_ERROR("no encoder found for crtc %d\n", pipe);=0A=
 		return false;=0A=
 	}=0A=
+=0A=
+	/* The command-mode counter follows TE, not the video porch timing. */=0A=
+	if (dpu_encoder_get_intf_mode(encoder) =3D=3D INTF_MODE_CMD)=0A=
+		return false;=0A=
 =0A=
 	vsw =3D mode->crtc_vsync_end - mode->crtc_vsync_start;=0A=
 	vbp =3D mode->crtc_vtotal - mode->crtc_vsync_end;=0A=
