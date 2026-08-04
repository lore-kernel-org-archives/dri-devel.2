Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A451EC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041AA10EA72;
	Tue,  4 Aug 2026 14:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="XAmHdPFX";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="RjF/EukY";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579D310EA72
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 14:02:34 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CVAYo3698435; Tue, 4 Aug 2026 15:02:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=fSLcFNFZPGpqxmIE+uqbNw4wMQN5LpC78dVedxnJvU0=; b=XAm
 HdPFXMWCg+uz36lbfFqe4I24VBfCXE8yGRW+9wHN2H0lejJSKdCQzFdSZkeqpH1O
 JEEao0LkcX5Goe1ylTpUKkKY1fiTuP/XoPVq8WktcF0DUhK8Vhoki5ZE2KQ/1g4e
 qCsTXcdk3WdbnRDG4w/jr1yDMMONazpwHdB598NZEE3WqYJZVtvmu2Y0ZQCnjmbG
 U9soo6X+z5K9QiSrJ3rUjkKmNliXX6g9b2lcLEBYx+OKyXmRPE7sEOJOf9DksF5K
 XHPPG0UaKnxd5rsOeiJ/GtzHKVu60NcVi6prgtingvkRfWOO2fvrIaME787drpzc
 7nEKDMLaewU5LGEo6pw==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020094.outbound.protection.outlook.com [52.101.196.94])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fs8vtts7t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 15:02:27 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfkTfUi/mxFT19gyFRzNJBdDgAplc3HhaK8AwE5yq/dtOMeUslo+3/Ld1xUs95q0uxTLYbRv7msTVFq3DxEChguWWEerYFbuVTTIMCjt9auk1j0v84jCUho9wsv8dG1jVS0rXZXHLQBbBl7KmpU5kkLHpYSywT5y2RMklmQCvgIjcp+X1V5zMwlw9p4a5VMv5LrK5lrbxODaDjFVjlXNgR4CeFWR2/KA2gLm+hfjBf+sN5ReiJdMP6Sg3+59QxJCx3WSn3Z6CHEVzdYK/ztrv0wFfyTrtb9X6/YjOgR434hKfzWkaA9mf/WXHpZDs3c9knD3GTGfjNkKHptTO/0ICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSLcFNFZPGpqxmIE+uqbNw4wMQN5LpC78dVedxnJvU0=;
 b=ByqPa9DPB2pvUPDDZbZVRDhmI6VCkn/h5vSWDWgv3tZ+9kLSczloyd+5Dt3k7aOccggHiozGE+ocSVkknYhLlD1c8DpaW1H6VAHU1PsRf/GMVR7SPs0zCO275Oq6MQEqR4xDqWkLSVb70n4FM6RlKCRIibLc/qDfR11DT8Lvb3CFnUUkK0RfNlnn3CIDfyvlww2W4JwrMfKgBBp9PtBn2LilzKgnaTmm5vkkIFrlZPc6wS6y8IIVzNHeWd7CGFW3fNRz1y+Z7bOZqKzbRWSmZZN9l07r5VJtAF455LLGTW9c0uEGEOgPgLC/+GfufSFMbY9jpOtqGrjoI3qgqw6vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSLcFNFZPGpqxmIE+uqbNw4wMQN5LpC78dVedxnJvU0=;
 b=RjF/EukYpXD6Mnl2YJEUMdEhc/boDdMjrMTZOTyORP6Qxvtx40jHY6kndR7BM589qQF03WjCY7o8cd9vpoIFXrQeIF1a/wm3roy/oNb1eddxojW/xU5s68JTdGBTObHjqe4OtD8j+K3xzIDHHBTFnVg6Nh1Gib2wP2QZPZ+WOtY=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by CW1P302MB0903.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:24e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 14:02:24 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 14:02:24 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/3] drm/imagination: fixup some docs in pvr_gem.h
Thread-Topic: [PATCH 1/3] drm/imagination: fixup some docs in pvr_gem.h
Thread-Index: AQHdIzIGHY4g1+rN/0mm39y/Z8sw4LaN7VqA
Date: Tue, 4 Aug 2026 14:02:23 +0000
Message-ID: <b58e73d6948afaf40b3760849400495b183aaca4.camel@imgtec.com>
References: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
 <20260803-staging-pvr-docs-fixes-v1-1-0d014c7b2671@imgtec.com>
In-Reply-To: <20260803-staging-pvr-docs-fixes-v1-1-0d014c7b2671@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|CW1P302MB0903:EE_
x-ms-office365-filtering-correlation-id: 3f15786e-8f0c-4531-76f8-08def2310258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|38070700021|56012099006|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: iUk3yqXwWYrI7AfJNm8lYsZllGxkf2P+/PMPi+YGbDqIRTwKFr8hjHTV+zMSYMW5Yfrqfd/HJQ3Dh+qPuxpMNZld7qC8K1kAIQ4RnCApJeor7dz2L+IhiFIVt4im+rwdTRM1bWVCJbSaJNQYfKHv6y4pyPPWhFHluw0kp4bKUY2BpCjqRaHJIz6I4bQZ92uTRE1tm5eFDiTw2zuhixlwocAbThw+2db95SoZQdse1koUC/fqb9GRVuL0ydYiJF6VfvPAQR/uyPHusQYxUX+lDsTW4fX1mH8dK39kyolKd1NLItaWEKJIVMX4r3Iecez8CkVu00yUEPjK2XCchqcl2w8r1LVOXw/qJ52M4E1Ch0llZllfcTznms/p0Vw02q8tmxBxGRh21gHASLKUFv3YRccAbW+k7ZrZkWRNInYc6fjyZqa9jiTqC0JcHCmpWZvsC1e+/R6jSvdFSJfgD5IPPRaqqZILkK3LTExMtnGiCncOQfolrZrKFGr1JfhgTbSKD6jroiWRo5pi5REpq8Jj7jRN976NT5Y6yyKPipRBvSdLt7myDvWjU8YDMQe5tKs7GM0+cezwZ2qlOmfWKocA0nuZhJy0PPmrRSovUi11/JL69Fm6swV87+vBq3s1N3Tj867EvOQJYfuTzSy6ExoTaPN+dnieRHrFHtQyk5qF9N+ZY1PMWmdf853Pv2tUjC0ChZaOpn0nK6kprTW0ESfu9gH1jMU+rjy4Ytxf38JgG3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(38070700021)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NSSlhEaHVFRnQ3VEVXcUdCbUZXb2IzeWhBU2lsSDFXeVFMVlpnaURJODlC?=
 =?utf-8?B?dTZqc0FERU9EOXU4dFoxUGs0R2JNelpRRmRpYWVTdVJlYU42S1h5cmpaeFhI?=
 =?utf-8?B?N21jd1VxcTF6NzVacUFMRXFvcVhJQnBvUkJNTkRnajByS1hrR3VzNTRZQjJW?=
 =?utf-8?B?cFFnTkNFS0tGRVRLU3JUMG5MM2xVTTU0dVh4YUY3SGtVeVZQeWExd1lEYXVG?=
 =?utf-8?B?eUFTYkdjZjU1a3IyeVRIS3NxSlNTaUxNV2NTT29POWpibWVVTnZXRnZNYTF2?=
 =?utf-8?B?dXl5NTJDK3ppYWR4WUxxTkRXWXJFTFNwSzMweEZLNWVzZ3k1bDB5NklFWkxx?=
 =?utf-8?B?UmhOMGZ2aGJOZnZZVlNVZXBMVWNzeUZzUkR5S1krZkcwaVZJMVZnZVg1SlA3?=
 =?utf-8?B?NnkxZHRwWE5HaEFDZlNrRytVWmprcC9Oa3Nna2puQjJSMnh0d3NZaWhHNEVW?=
 =?utf-8?B?MUlSLzYvbkkySzZKK0JtL09YYUpOcUpaNER4ZlgyQVlHS2NIUDlBV0gwRG9M?=
 =?utf-8?B?cGVFSld1TzQ1V0QycEV3S21CSDhmV0tKcTlESEdFQm84Q2RLT0hBMWJiT1hQ?=
 =?utf-8?B?Mk92eWJRWUhNSzE3NFZVeGNUbW81bE04NE5xY1JkV2xoOWlJSjJxNmlPZzd0?=
 =?utf-8?B?Mk9nUERtcmVGTVF1ZHlWdWJkNnV6THFxU2xyTVpjd2ZkUTVxV2QvTlAxNUkr?=
 =?utf-8?B?enBERjRWZnBQWTQ4YnhDU1FpeG82eTdkYnU0K3l6Z3BuZW5LdWFoSVo3cERv?=
 =?utf-8?B?MERKSExMTy9nWlJDOVlubVVuWjl6cFFTUnR5TkswV2FpSml0cFg1SGFXbnBD?=
 =?utf-8?B?aVR1ZHd3RGo4ZFRXb0pXNmpBL1YyQkFJSVBqREI3ZXpKbXJmVFAyNXBIOVV3?=
 =?utf-8?B?Z2s4ZUZaNDQzQmtMdFBwb3A3RlQ2ZGE1ZjJqTUF4VlJtMm9uZWRrMnJTclNX?=
 =?utf-8?B?d0RKaFd4UXZzQnBvUDZPa0hqd1lxeXhTa2tNbGVmTCtUQ29IMkh5cStqL0kr?=
 =?utf-8?B?Ym9rby91ZlNQMTBSazJjOWhDd3NBN3dWWmUreWpJREp6VFZNTnRVRGRzQ1pt?=
 =?utf-8?B?cFBNQjNGdG45d3hla0xTVjl5QW1lWFRTZURWYmxPb3R1cUFyc3RIN1hCMEhW?=
 =?utf-8?B?WEE3eVNCZzVnQ1ZLSm44OEhwRmRaUWVEVkJicmFlQXI5ZDR2OXdZQU9yR0tX?=
 =?utf-8?B?cEt2MHFQcXUwL2FPbTNJTFFNV2ZFWWdCSEowaXg5UUsxSUxwUDg0TWZtM1BB?=
 =?utf-8?B?TjBXTUI2SFN2VXBhUXhPUGhORVF4K3NxRzdRY3R3MU1Bb1pjNHptT1owb3B6?=
 =?utf-8?B?b01CSEEwc05BNisrVXdyZC9UeXRsa1FNWHdya3RYSllOUmMwUU52Tkc4TEJs?=
 =?utf-8?B?OVIzYi9RRHVsUVU3cFF6RVJDejdERDVPTE5md1Y2eGh0QU45MktpNG1GQkYw?=
 =?utf-8?B?cVRqREZJVGZ6bDU5aStkYzZzWmxrb1VKVm9qaGwwYVlPdGVPalg3ZDBrMGZZ?=
 =?utf-8?B?Zmc1ejFDbWtkcnhrdTY1dlRoVWp3Uk5CUk5rc25zZGVxYzQvUU5UcXhEVVIy?=
 =?utf-8?B?Wjl5aGs4Yis0VlIzUzc5VUN3UXJ1Z3l4T0FTYzJnVTFJL3FzYk4ybVQxOVk5?=
 =?utf-8?B?bkJ5bVMvVWs0MG9zM3VQUW9hbzJHNXZqY000Y2lUVVRlOEtPTlVGZGtOQVh0?=
 =?utf-8?B?dkpXcndiSHJhbVFQL3VRVTZmYXBadzh2dEhzZGREbHV2V09PTmNPR05sZDlH?=
 =?utf-8?B?aWhLUjVkRTRSZ2dhdytFV2xBSVJkSVRNOUxpOTE0OVE4dWVGTW4yelNSMmt1?=
 =?utf-8?B?WlJ4NUFOVEV1NTIwNmxUcWtiSDlNYm0veHMzKzNqajB3dWRNRjJsaFUyTmFP?=
 =?utf-8?B?RStXRld4VXJDa3RhSDFiZUxRZ2lBMnRVenFZN21PaEpzUHFOZTZERFI4ZU9T?=
 =?utf-8?B?NlFqMVVxTUxKbzVtTTFQSHNTazl1cVJMTmFkRDZMekRQdXVhTS9IRDkwMkFK?=
 =?utf-8?B?ZVpjak9wOXhSaU1GQlRoaTNpREtURW5DRzcyZGVxeXFjby81Szgrc1M5SHBL?=
 =?utf-8?B?L1NBeUVLZEFZU0kwNTZUQXQyK1U0RWlOcGQrQmVOMVV6SlJCb1hFbmUzRkFv?=
 =?utf-8?B?UUN6QnFtblgyVFRGd2xxVndxR1VoZ2FzMlRpQ1V4Y0dRRGN4UFRCWWNKL0VS?=
 =?utf-8?B?YmdESFF5ZEE4V3l2cmNnYitGZjNwdkw0WnBXYk8wa1YvcWNpMXAxb0JvcXNZ?=
 =?utf-8?B?bktRUWZaaXJCaUxjTTJEWWxJbUJFNWowV2xhdkFPU3c3eFp3THYrNUZTQVpB?=
 =?utf-8?B?NGR3VXNVQzU4bE92czdQd2taSThwcDZhK1BNTHRvRDAzeU55aGpJYVFiVG5s?=
 =?utf-8?Q?oPAkO6YuISp9un8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFCF1DA8F2EF6349B4FDD5F2EABBDF54@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nw/LvA6hS57J0d1Jn/7tCthvpHJ/e8MzFmzfi86JoPn7iHJcHxh27ApbfPS2xjHWsKOUqj87d8/hx7p6DBsanFP5eZ/DYwx6gizgPO1AB62s8+m4DkF5y9tT4eTHqc2HI/LZtyVkogp41PYZZ2AbrRO60fTKeqtEmgrm1gXejqTus7JaE6gfOLZt+QGEutYeB2TXmCqr1OlLIDgZdCW3BaxoexUEZuwkNCh0BoPTbs69eabBdRMpspXg1ti15aXntMq5o31bxkD+AfD+PFuijXFrI6JUqPh0KTwRxY99PTcCwb/2V2Ax+sUyMYaFxEp7VHXUcHNXpVMcrUlbyIVuyw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f15786e-8f0c-4531-76f8-08def2310258
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 14:02:23.9464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHl6ZyC3OwdL1KYqcAj8cQCBBzl47UHN1yrwO0b5dU8Xexf1RX57t5fpW4jfAJiBVidibnWrNQ6N2dY+jz5JoVKtBikglOwgJjO/sL3sbFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P302MB0903
X-Proofpoint-ORIG-GUID: w4DBgl0OwXXYVacUw7ss_CM9mfZCd_te
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMyBTYWx0ZWRfX9Fs1qk5hKGSX
 i4OCxVBPquUQHdf0HtnyB3c+tsAYKOqxWBQhbwpu3DgJL5D8oW8S/f1hefDhFeXERwj1H0chEhG
 UAXZm6iN1uKDBIXgLprols43cF+wpV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMyBTYWx0ZWRfX0xN9du+Wl3Di
 U+vdo/Rl6Z1TKK52h9vWRAEw4ECPr5J+LnBJaSiO5VO+sGocEzwF2XwQeknVogBsOYV/PKw2qe+
 qCkcc61z4oqAk8gysBpajnPkcAszWmuNPopHk47bD1jue5sf626GJFkwt4k/oTUBqA3XbReb5Z0
 lKZXHo1gEMv2SiCgDHo6uHoW9O7vr95bSZyTsCEA0RlEzS/wfZ+dfTABwaCRAXstSxriztqvPJS
 LyVKmRbad3kkxKg0bCrnmROMjJJIQa5yhmqmB+ILmlfWmza6DOIuLEhiC4ZyQ2pBwIJSAMRdnFm
 kKp/yElQi8cV55SCFyY7+d4CJybuU76MsWCnNAiXcxNu2CXxbxd0WY2JlAFo+N/MmAusZTpNnMz
 Tq44PgYrpEyP7oulPrJVg0bZ8+vebuXaksL3cGbxtyb9mFfH3KEAI7ewyUL8t/4OjHa8kHDSanU
 lwnOrtciEzrZ4oh22gQ==
X-Proofpoint-GUID: w4DBgl0OwXXYVacUw7ss_CM9mfZCd_te
X-Authority-Analysis: v=2.4 cv=D7V37PRj c=1 sm=1 tr=0 ts=6a71f0f3 cx=c_pps
 a=udn/CxDWp7++EjhRhf9glg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=dvs2vc670xQcbALM4yUA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gTW9uLCAyMDI2LTA4LTAzIGF0IDExOjIyICswMTAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBGcm9tOiBNYXR0IENvc3RlciA8bWF0dC5jb3N0ZXJAaW1ndGVjLmNvbT4NCj4gDQo+IFVw
ZGF0ZSBhbmQgcmVtb3ZlIHNvbWUgb2xkIGNvbW1lbnQgaW4gdGhlIFBWUiBnZW0gZG9jdW1lbnRh
dGlvbi4NCg0Kbml0OiBjb21tZW50IC0+IGNvbW1lbnRzLCBtYXliZSBnZW0gLT4gR0VNDQoNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBMdWlnaSBTYW50aXZldHRpIDxsdWlnaS5zYW50aXZldHRpQGltZ3Rl
Yy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9nZW0uaCB8
IDE1ICsrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9nZW0uaCBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZ2VtLmgN
Cj4gaW5kZXggYzk5ZjMwY2M2MjA4Li5jNTdiMDgzNGI3YWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZ2VtLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9nZW0uaA0KPiBAQCAtODEsMTEgKzgxLDEyIEBAIHN0cnVjdCBwdnJf
ZmlsZTsNCj4gICAqIHN0cnVjdCBwdnJfZ2VtX29iamVjdCAtIHBvd2VydnItc3BlY2lmaWMgd3Jh
cHBlciBmb3IgJnN0cnVjdCBkcm1fZ2VtX29iamVjdA0KPiAgICovDQo+ICBzdHJ1Y3QgcHZyX2dl
bV9vYmplY3Qgew0KPiAtCS8qKg0KPiAtCSAqIEBiYXNlOiBUaGUgdW5kZXJseWluZyAmc3RydWN0
IGRybV9nZW1fc2htZW1fb2JqZWN0Lg0KPiArCS8qKiBAYmFzZTogVGhlIHVuZGVybHlpbmcgJnN0
cnVjdCBkcm1fZ2VtX3NobWVtX29iamVjdC4NCg0KVGhpcyB3YXMgY29ycmVjdCBiZWZvcmUsIG9u
IGl0cyBvd24gbGluZSAoa2VybmVsLWRvYyBpcyB0aHJvd2luZyBhIHdhcm5pbmcpLg0KDQpXaXRo
IHRoaXMgdXBkYXRlZCwNCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVs
bGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+ICsJICoNCj4gKwkgKiAuLiBu
b3RlOjoNCj4gIAkgKg0KPiAtCSAqIERvIG5vdCBhY2Nlc3MgdGhpcyBtZW1iZXIgZGlyZWN0bHks
IGluc3RlYWQgY2FsbA0KPiAtCSAqIHNoZW1fZ2VtX2Zyb21fcHZyX2dlbSgpLg0KPiArCSAqICAg
IFRoaXMgbWVtYmVyIHNob3VsZCBub3QgYmUgYWNjZXNzZWQgZGlyZWN0bHksIGJ1dCBpbnN0ZWFk
IGJ5DQo+ICsJICogICAgY2FsbGluZyBzaG1lbV9nZW1fZnJvbV9wdnJfZ2VtKCkuDQo+ICAJICov
DQo+ICAJc3RydWN0IGRybV9nZW1fc2htZW1fb2JqZWN0IGJhc2U7DQo+ICANCj4gQEAgLTk3LDEy
ICs5OCw2IEBAIHN0cnVjdCBwdnJfZ2VtX29iamVjdCB7DQo+ICAJICogY2hhbmdlZCBhZnRlciBj
cmVhdGlvbi4NCj4gIAkgKg0KPiAgCSAqIE11c3QgYmUgYSBjb21iaW5hdGlvbiBvZiBEUk1fUFZS
X0JPXyogYW5kL29yIFBWUl9CT18qIGZsYWdzLg0KPiAtCSAqDQo+IC0JICogLi4gbm90ZTo6DQo+
IC0JICoNCj4gLQkgKiAgICBUaGlzIG1lbWJlciBpcyBkZWNsYXJlZCBjb25zdCB0byBpbmRpY2F0
ZSB0aGF0IG5vbmUgb2YgdGhlc2UNCj4gLQkgKiAgICBvcHRpb25zIG1heSBjaGFuZ2Ugb3IgYmUg
Y2hhbmdlZCB0aHJvdWdob3V0IHRoZSBvYmplY3Qncw0KPiAtCSAqICAgIGxpZmV0aW1lLg0KPiAg
CSAqLw0KPiAgCXU2NCBmbGFnczsNCj4gIA0KPiANCg0K
