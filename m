Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AF6CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5532010FF00;
	Fri,  9 Oct 2026 07:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="DOYCo2Ve";
	dkim-atps=neutral
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com
 [52.103.73.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484CC10FDA6;
 Thu,  8 Oct 2026 22:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJCYEp1DF8pmAYOQ4DXuPLrGKksWSPs67Sfe3iryWTvuPCGfIdluJOv3ohvjYdJ+cVzpoLe0s3N0kndVa5pfwbonCgn9JuwMDPjVUi0ah1iEOR/EKsNj4+ZCQ0zeQYdM0qETX6GitIPb7fi5HZVd6EPU/mLSk1Fsj0tEegtoDXcE4VQCRRNR4hiou4m/SNQ8Ljfoc0IcJrxJUbrUscM2Hjv8cGNeEDA2e7/sw3/X58Wv8tO4lH2U1cOVCBFaSp0EAIVNqDqHmV94yvJRJ/9OiiCIVlR4yNe2GkA3FEI80z6rQNRSsWw91tpovS+NeJX9j0fkJzRnlrBHL1kJjDwSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYtyvgkerawploX0uNmfaFwZM8g4J6DQg+uSdDE9Qig=;
 b=MjS7qBAHd2/cuVJnBDFcb5bPmYbZ4Dt/j4qmdq932rXPlhqBjBOjflzmluDCWgR2ltUB1Fygf8Kuru3QxQ/3Lg5WHNUEhkIlhlqIBaQjTbRWFzKndOvh+6MZkSgfVSvPPEawr3IvcKXFsm/ZdKsz7Av4Ch2x+ayGdyvfz6L9CQ3gNYops55GNy0kcAlwPoNgQsY2QcqTbFJ83MBKNz6O3L5eawvk9L84k4QVLwfycsUj8d9h99HaycoMQfb+eJ2YzLUYuZrXZDwzZ9MraeIM9vHd9QpIoanFsMSEEJGwq4l/UofwBauWEZ2jWawCKdZL2JH4/2u8jiHgmgbLivP0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYtyvgkerawploX0uNmfaFwZM8g4J6DQg+uSdDE9Qig=;
 b=DOYCo2VetV4fBFKbckwsd6pLihbR+0xl785eLvvLOyPDmIFeCEUnNuxgUqpBox4hrqs8FiTWif+8tn1ndTH3gABYfe1OEr1n9tYPtTCUTzTvwAaILF3OsL4aO2A7QjV6ukYyDxQzaq2CAzTxO30of5JWfjt3IFKUoGHSYCLVexUPU9Cabrl+QaLn+2nMi0n55kEuOoR/irUbEIZ/BWiKEnwnpKc/h7dWKK84jKc2WWwzjgQTDsOfNV015EJXh3NSnUaZ22/jxr/5DqaQJ4ckZFpWQ8jepn1juz7T248bQCjqgrhT5iR/SuWpvEQ0aggxHwsUr2vAp8zWk8sD8nztJw==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY3PPF346C5784E.ausprd01.prod.outlook.com (2603:10c6:18::40d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 22:34:50 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 22:34:50 +0000
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
Subject: [RFC PATCH 1/3] drm/msm/dsi: select RGB DSC 1.2 rate-control
 parameters
Thread-Topic: [RFC PATCH 1/3] drm/msm/dsi: select RGB DSC 1.2 rate-control
 parameters
Thread-Index: AQHdV3U77he/AKtsl0SVhoYpaPc2lA==
Date: Thu, 8 Oct 2026 22:34:50 +0000
Message-ID: <SY5PR01MB10600EB45BFC28E0F932593E7A1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY3PPF346C5784E:EE_
x-ms-office365-filtering-correlation-id: 735cd52d-602d-47c1-bc24-08df258c5dc1
x-microsoft-antispam: BCL:0;
 ARA:14566002|39105399006|8062599012|19110799012|4140399003|31061999003|8060799015|25010399006|22141099003|25031999004|15080799012|41001999006|38102599003|24021099003|16051099003|102099032|2607281247196008|440099028|26104999009|3412199025|40105399003;
x-microsoft-antispam-message-info: =?us-ascii?Q?dBw2JYOKCkg4Rtmn5+CIBjVL2BviXudnklLrrgoc54rX0LChD1Guejct9d1o?=
 =?us-ascii?Q?2baDJmnnjJPExbT//UaRqsq8+j5s0ipTkV70cpTLmzeAmC9YK1ss7tPE0CcG?=
 =?us-ascii?Q?KxEfhWuLdF4CnGR3LQHea4SrADtryCOMDDlWS/U4hMortLFiiL+XUzj3RdwF?=
 =?us-ascii?Q?Kvyidx/evJjJ4xOkumqaCmIT9XkCIObCnUzn/Rc3ddtpTMT81BpDsW6CoMGz?=
 =?us-ascii?Q?ROuZpC3OMhbJcRRmFk9lFVCcRiU11omtw2ii0vz7OWZyhR6a4CK30NmA39Nh?=
 =?us-ascii?Q?IkGffzJIgE3TR73R7JF/wxDAh+u9RocyqQ4JPrHX3IAfTrFDPeMslUBQJu6z?=
 =?us-ascii?Q?pNSMn6mO8LXr9v0weaSr6Xrn9KXRgll7M0DOWQs8nGB7glntJRYWOUuv9dCo?=
 =?us-ascii?Q?sDwG+HF5hK6qDtffJwAK0Pf/q5ZLqnFPmz0rqYqJKc6pW+bGztYbiGQyLoKT?=
 =?us-ascii?Q?/HOHEPJnCy7/uZ0EbzSyb3nq0MhdCvHAwHMPQAvspCUIMS/08dwKdrS/odXJ?=
 =?us-ascii?Q?RVUlv4Z8EQ8EiwWWnMaGtZZnFFkA4hwJRbQUMd5B2nXUVd30Xz4B+r3GB76r?=
 =?us-ascii?Q?tBkboOxZXx3MzTuZ0Z0m2stdNZRAX86ZAqi1M7AZ4JPRCulUp1c+bZTEDZCj?=
 =?us-ascii?Q?9HfkbI5+eui5RIzPjMpi0KFkOGusmS/sYUlb26p89uKBKJAIUU4WJ9yFxpDU?=
 =?us-ascii?Q?B98gciJszdP+JuKOoWut8O+RKjozBMhnfk/vYd4Ou7WtYo0+NbjPcZrSoIAt?=
 =?us-ascii?Q?lXQQrR7+o9zQIWBzp2/gYaeFkho27HKVKgiCs2yEpTZALStNGtp4xx8c9Iis?=
 =?us-ascii?Q?usa9RUH2dBW8IMHhKNEwGozB/H+maHqZbnKlOwjAxRu/BcvEBlLWW/OD1Jnb?=
 =?us-ascii?Q?wAk2OWeSPnJQTXYBL24K8wL9twk3T1ZRg3vu0GAbJiShTVqG5oEInEKt28ta?=
 =?us-ascii?Q?AQT4Bp6/e9M67UwYQJ06bXn7Ozo/sVUCOEu5My7hfpEXQffMUE1px0ZbC91p?=
 =?us-ascii?Q?FoZxhmoq6sLpMs+7TW4xH4a/3Sslo8eMbGr2IkZQ4Lo5AgDygsc3Tk2JrGDK?=
 =?us-ascii?Q?+oy/IxXumq0dn6kdzPxRXn/f5HGxOw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PBCOQ1cxASq2TuYjrV+dSNjj/92dWdqLf+3QRVZh3nuHe5ZTeKuaiCt415TC?=
 =?us-ascii?Q?k45TTtMjfZCAdjG09zvMVi6rRDyHR0cgHTwyKFGso46ym1We3a0s0gSG+tbd?=
 =?us-ascii?Q?GdJmD7/epSgpmz2JZbtMfz6oZq2L76Jy0Ln56PzkltUnnpPB5IQhscpM3StP?=
 =?us-ascii?Q?lsyVo5Uwt5UojhnkPuy2qZA+HWv0aRmSroneliRk0VhdQLFYRJkHXov4OMLz?=
 =?us-ascii?Q?zwGPlqEKK+LDg+noBw0rD2R7PlG7b8Xk8joyNG+Nk/MOGiOk1zqCG2VYb4ak?=
 =?us-ascii?Q?y0UZ8tZsqtJeYpv9f06h2z1CBagtCxhs4Da4JMD+0VWT1oNnWxtCaFRXlsaM?=
 =?us-ascii?Q?jjf3QzZCG/XcLJNtPpamcpVmK62rPk/985+gNKTGLGY+uCdIw5+bp+jEp0D1?=
 =?us-ascii?Q?PIJNnwbP6L2+WaotFJ26Tmdv//7V2lJsncPYwk+y29nqmNWSKxeUfsic5x6g?=
 =?us-ascii?Q?HYFtMFS0Eojj5UP7SuUIM7a1JlKl6+eL0CTJlkraJsh2vVFv5dM3DI3cVBZV?=
 =?us-ascii?Q?EK37jfuvoEerElZJzJO+1Edla2nPkpaMEqU4AQTPi+84U0K/ZAxJV7HO89pv?=
 =?us-ascii?Q?2L/g3aqZlaRcxqT7JFgaLNvr8zI7vK2g2NX16jfZPwpF9CmXSuBjZuPUNZAx?=
 =?us-ascii?Q?1fh0BWkBU7UAfZWuQbdBg7V3oWgXF9Zv9+KzwIy/T0Lf94SVeWxKGH6vk/Bd?=
 =?us-ascii?Q?0LS527eoPmBW+l6GDjimo7WdtVWbROqnY/riw5o8tyfhXfvvk8YMmiQijDvg?=
 =?us-ascii?Q?uoBYXyf2QlLqmUC+PLrFLf19HUPT72PXBxoJJl+3LtoVwDvZJyC3MKl/nIWG?=
 =?us-ascii?Q?bo7NXQeuVu1W4QJznR4IOv05k0RzS5tDjrSACsxJZ/760Ge7/54Z2VCoWUki?=
 =?us-ascii?Q?FkZRHqZkBtjD+5VMDzx0AMNrDHCwJMinYaBzVKHtsscJPc3E7TnuixvIQywI?=
 =?us-ascii?Q?86VB5a1M88RpRq56+QTAg8NlB74a+zVVhKWBKWfQ5qKWsxOTC2l46tXYCStp?=
 =?us-ascii?Q?SgN1tPQp7FgkMqVDuo9UtGZZiWPraPbQTBqHo5RdPCw3iPGM9R8G3J9p1kCA?=
 =?us-ascii?Q?xWaiH1fnra/d5mghp11INTIr1Ltms28Hw10335x8eWnjSv0Sc/9SyFidvi9L?=
 =?us-ascii?Q?XCt8gjeGBpKyNteoeC+QMCUyhRFw8Igewy0h8GQKZoPnJ2+BX87dYSHlpUwG?=
 =?us-ascii?Q?gNbpcE4NlJD06xIDCgUTxWjEcsx4hKdOQoFicjp2zYvZsl+bUcOX0e15uBTK?=
 =?us-ascii?Q?VCVnDlw6/mWsryPl7MyGK4BpYhOZcOIi+VP+Q0hl9Jq8wuu4e7gx8n76WMad?=
 =?us-ascii?Q?Lvy6vdl+8eQFs6elUUbyeuvHLWsCnBX1tcAoyLwZFJ9/FBpdsM5lBk+0TZc0?=
 =?us-ascii?Q?d/h+B8J+binumi+SGAeJc6785eD5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 735cd52d-602d-47c1-bc24-08df258c5dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 22:34:50.4115 (UTC)
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
The DSI host forces RGB conversion but always selects the DSC 1.1 pre-SCR=
=0A=
rate-control defaults. For a DSC 1.2 RGB configuration, select the existing=
=0A=
DRM_DSC_1_2_444 table instead. Its recommended parameters differ from the=
=0A=
pre-SCR table even for the same bpp/bpc. This changes encoder/PPS RC=0A=
values, not just the advertised version.=0A=
=0A=
Limit the new selection to version 1.2. Keep the existing defaults for=0A=
other versions and retain byte-clock rounding, slice handling, supported=0A=
component depths and fractional-bpp rejection. Reject native 4:2:0/4:2:2=0A=
rather than combine their flags with this path's forced RGB conversion.=0A=
This does not add native YCbCr or future DSC-version support.=0A=
=0A=
The table definitions and mode-specific helper are public Linux DRM code:=
=0A=
drivers/gpu/drm/display/drm_dsc_helper.c. The earlier Warsaw display recove=
ry=0A=
is supporting development evidence, not a new hardware test of this target.=
=0A=
=0A=
Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
---=0A=
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/d=
si_host.c=0A=
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c=0A=
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c=0A=
@@ -1877,7 +1877,12 @@=0A=
 =0A=
 static int dsi_populate_dsc_params(struct msm_dsi_host *msm_host, struct d=
rm_dsc_config *dsc)=0A=
 {=0A=
+	enum drm_dsc_params_type rc_params_type =3D DRM_DSC_1_1_PRE_SCR;=0A=
 	int ret;=0A=
+=0A=
+	/* This DSI path configures RGB, not native subsampled YCbCr. */=0A=
+	if (dsc->native_420 || dsc->native_422)=0A=
+		return -EOPNOTSUPP;=0A=
 =0A=
 	if (dsc->bits_per_pixel & 0xf) {=0A=
 		DRM_DEV_ERROR(&msm_host->pdev->dev, "DSI does not support fractional bit=
s_per_pixel\n");=0A=
@@ -1908,8 +1913,10 @@=0A=
 	drm_dsc_set_const_params(dsc);=0A=
 	drm_dsc_set_rc_buf_thresh(dsc);=0A=
 =0A=
-	/* DPU supports only pre-SCR panels */=0A=
-	ret =3D drm_dsc_setup_rc_params(dsc, DRM_DSC_1_1_PRE_SCR);=0A=
+	if (dsc->dsc_version_major =3D=3D 1 && dsc->dsc_version_minor =3D=3D 2)=
=0A=
+		rc_params_type =3D DRM_DSC_1_2_444;=0A=
+=0A=
+	ret =3D drm_dsc_setup_rc_params(dsc, rc_params_type);=0A=
 	if (ret) {=0A=
 		DRM_DEV_ERROR(&msm_host->pdev->dev, "could not find DSC RC parameters\n"=
);=0A=
 		return ret;=0A=
