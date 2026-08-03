Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A668C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486BD10E6A1;
	Mon,  3 Aug 2026 14:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="qAgmYEVq";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="UqIRvfyM";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B25A10E6B1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:54:35 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EAqTD1294680; Mon, 3 Aug 2026 15:54:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=DY5fxdi/CznVAiJjk5kDvGClTMsE4/Mc8+FfXXNvVtI=; b=qAg
 mYEVqisHbdGao4e6qnLY0okvPy5orT7Ncc9io0xuIcvSIogxHETvbH487gFzLTcs
 ayu6rFvAd+53kkbdNPpoJIhn+kwK57C/vzVmDIl31v13icoE85LF48DvtmTaJVNa
 btTmdLFWBB5bLyABrZ1vNgSRGQwPzHeXTibkNHYns1qJKsesmfuS9537oyaAKn/h
 t0/BURhSisRUWfSiheii17NCShrpnOZ7sFm5Q1SxNUTD7Y/DKKUTcu3Qwoajeljw
 afZwwbI7mlCKBQJ1qt8Ll36ymXyVYsj3n8hCEnAJ32exr2pDs5DI4vQ6+qmVU6zH
 nwWHcLGolRZDGSdDULQ==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022143.outbound.protection.outlook.com [52.101.96.143])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fs8vtss5w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 15:54:14 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPpvheNRbLbQzaj9D0UCVpBFvXzsz567EWgtnWK1ty1XmUSR3Bkv7nAXfdlAxOIMgW5cjekevxWvyGY9nFHj0Kic017byTimttu0wswIUqCn7eWNC7V1jFU8rYgwrmyc+iANHzAoslANnoj8c9R7pQn+L3qCDhV/JUJmlzdq+QHEqs2yWA5UR52G5HxWD6sqnDMCzsHGq0PlAgMdIcQBxgkzVx/MgyVnpID7OYJUTuX1xwmVSIVh2CnlZWutnpBAOqAkg89akso/P6oQcwb94/NE8GkuUGybgruP/rxF9zRv/wAfD2Ac97rj9MkvbdkFy0vd/8+RZJSg6+BNYutAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY5fxdi/CznVAiJjk5kDvGClTMsE4/Mc8+FfXXNvVtI=;
 b=Jy+sP1FJ9ireTJmM8nt5HPcaniHu7fNulbFHv/W85cx7aSllCXl7EWcCHILLb4TYaLk34fWbh64eV1o/TvjCAsPzbD3U7ICFpxzyn2nvJrWAVuv9rlPKiL0f/5fjpy2LxVNgBrkE6ZmH+PKtQ6Rc0M9GmIsr0iVUz28VIuxgAbqq3nE2893NC4+5S397knm4HQCjMk7egv2AgVBH0IsglCmj7mRP/Q7ldhw/hcTt4sHmhnqy9/5wObxZjMEyVixJ46/5fokq9KL0C3YmNwwBQSJJ3u/0/sla4KXqZxFFo0TWVyNl8D2BFMj6wV7z2z7GEpzrip0X26kxJKvi/2/mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY5fxdi/CznVAiJjk5kDvGClTMsE4/Mc8+FfXXNvVtI=;
 b=UqIRvfyMpx+ZCrOIGN+y/mZIJdlAQoknzLh9xlUk4w8kJ5QsCCRaJcZzvEahSyqj3C2+bTNRm0uPvbPCfH/X4ufF/Iosta8T2NxNGZ3vK1U44/A7fJoXnyhHfyrad/nvpO/PlerOUSOcGWJpWaL+JtUJIz/Zwg7xmQDPMe2oHqU=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO7P302MB2317.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:44b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:54:11 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:54:11 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "boris.brezillon@collabora.com"
 <boris.brezillon@collabora.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Frank Binns <Frank.Binns@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>, Brajesh Gupta
 <Brajesh.Gupta@imgtec.com>
Subject: Re: [RFC] drm/pvr: define oversized freelist reconstruction handling
Thread-Topic: [RFC] drm/pvr: define oversized freelist reconstruction handling
Thread-Index: AQHdGnH0lYqGvcK4dE+HQYRkfoM4kraMev0A
Date: Mon, 3 Aug 2026 14:54:10 +0000
Message-ID: <72193a4ddde9f7ba66cf12a3ed68c22e917b1cbd.camel@imgtec.com>
References: <20260722040942.85459-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260722040942.85459-1-pengpeng@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO7P302MB2317:EE_
x-ms-office365-filtering-correlation-id: c37a16e5-723d-4b97-c550-08def16f13d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: fY8SYAelwgw0wUtEjgirDmESv4dYV12jqJIpCh/CIW/Wj5+ZSRTFuqGPg1H1oWOU9roXeazF4pNwavKU3aUHXK9DmbrzQAD25ALLxITzlsSNqLNRJu8U2NJ8CEQVcyrZlQfJtYeusW7QiomJzITpMggmCo72V/jQM8Db8S0QXolb5r/4FEtJouOAavIw+n/PYxDA6qbK4tM7KvakMYpg+r8su8Hk1S9Yv8ukBaDiVicU+lmyfG+GevgsyyxBbWdEbsnLv+U+rIvyF2mhY5C2OkAwOpXNvh6v15pkLZ6l9E15F8QiCgKvKELHrWkAcT8pdreMv1ekdu077I3jDwM/0oJv78s+SRxduShwQliRnQS/DudMBAHCJ5UiwayjNk/198t16CmbHF0isnZLrP1osEe79LI6cYBwgmJhPG+nLlBiC7i6q2Y1bOVcySIoOFehLteOUevuBG3e0yqnI6IwtaiHCwz2TGbu895J3zjmm6Kw4uuriS5bdtem+F8J2BGvuCO8/gYx6QyZL3YFLnZmNqTYqmuaYzBUcP7pleRLWbNbPts8EiP3pxQMZLUNScEc6hFxlU91y40b7j2IdaAKrU/qt7i7Jdlg3YuJQJ/8MQciRS3V/GHbpALy7DRu+bYS1Zi0GJh7CItt6xzQzCp0pFsr1luKbiZWsWYDMja5YzI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVcvbmhSZmw4QlJkMzMremtnU295QlpiWVFVbStDb0tqRjhvYzdqTVdZNUhE?=
 =?utf-8?B?Nmdhcm1zQ1BPNi81L3I1RTFmWDJpYkw3d3ZHaVhObkNBOCszOGFzYjJtMjU0?=
 =?utf-8?B?bW1wc1RXbEdGeWw4R1RaR3QrSTI4SllUMnpRY1BzcFAxVjNTUXZmRHE2OWpW?=
 =?utf-8?B?SHg2a0p4MmlmMG9YMEVhM0pLcGNUVTJCbXp1TVhaV2pMYjVKZmZic3JpNlpM?=
 =?utf-8?B?TkhhUjdRVW5uOUQxVzBQcVd5RnVxWDRoZFhZakNzZjd3MDliQVl0ZDZLMURp?=
 =?utf-8?B?M3VnYjhyYThBd1hzRjhrekRWMzRDNjllZzRBVmgweTVCQU43amxhSW9mZXkw?=
 =?utf-8?B?NktFY1VUYnFpVEhQdjYvUmo5cnZOUUlwcWhsK214QTJmd3h2amJOSXFpWGk3?=
 =?utf-8?B?a0h4a1UrSkw3a2ZyTVhDL1g5bEN5UWdwRmpEV2NiNzdjYUhUZzhqeHFmS2Rv?=
 =?utf-8?B?Z0ZnN0NUZ25nSFhMRmdhMkEycDdCR1FKNjhmZWRTNHI1eHhVckRHajZ2NWdn?=
 =?utf-8?B?Yk5ra3R2dDBINXJrV0x0bXd2M3R6OEdyeVI2ZURXZzVVblZRLzQwRVQwWGo2?=
 =?utf-8?B?b2R6ZEZkS0g4MnFkOFdyRHFyelYwU0trYmtabHZTN3lwbnFRUFB0RXZ5TmN3?=
 =?utf-8?B?cjgzd2VsUzh6L3lsM2s4R3ZabExJZFgvdXFXdU5FYnRYdWlILzMrd0lSSnR3?=
 =?utf-8?B?NnhUT0NFdmtIWFYwQktqSzVDUUJXRGJZb0dmZ2dldTRZa0xMeXowVHZlNDFH?=
 =?utf-8?B?NVAzS2pHYW85Qld0RmtXWWFkNzAyajZmYTRxU2xOSlNJbUp0dXlnRHo3bzZW?=
 =?utf-8?B?WWtacGc0c3IvU04wcDFObWRZelpkb09oczEvUmREaFR6UWt0WGtqQjY5cGdG?=
 =?utf-8?B?d2dOK0U1WWtwNjlmNTJsR0NTWTBjSTloTVpMWU93ZGc0cmZVK0dGRDBFK29P?=
 =?utf-8?B?NzBNRjZTR1hKQkdWOHphRG1lTWhEQkJ2L0tTcE5EcG43NHVNbWVtMmNlYVhU?=
 =?utf-8?B?YUZwaEpqcGRhQUFPU1lUWitjemJyTk1GUm9ZejY3NXhPNHEwZjZoSjV2cTBm?=
 =?utf-8?B?V09MRG9sWkh3VDk1T256UnFoT2p6ZDVwanNHUFNBTnF3VitpRXczdXFUa3ph?=
 =?utf-8?B?V3V0SVJ4OEZZRExVcWhmSHJLRFRFLzBMWGlUMU9MSHNQYmM2NUtEN0NicHhY?=
 =?utf-8?B?U3JsRDN2eEExNzV1S0pQVUk4VjEyNWNMMENsODNHMVlZZ25uZTR2M3dkNkZE?=
 =?utf-8?B?R3Z2TldjU3dSMENRdkx0Y1NmM0FUc2hCalpzQnZSbTl4Nmlrdk50RXZndXQw?=
 =?utf-8?B?aW9uMEhUdzhvQ2RXRmVjME4reDVQSmFqUzFUbGxQall6VVRHTEhadzErek9z?=
 =?utf-8?B?dlk1bWVtd21aaHFVanlPN3k3KzdDczF0OWl2RlVwSHlJakxHYk1UY3FKQkFo?=
 =?utf-8?B?TGZ1Yk1RSWQ2d09NUHFNQ2tBNm5aWW9Tc0lIY1FnTWF6b25hVm1rdFZpWWNh?=
 =?utf-8?B?dXJyOWNHWmRHVWdwRmMxZkZBdzFTWEFpQ2VSZk8rdTlhbTJwL0ZxZUh0Rk5J?=
 =?utf-8?B?Z2U4a29jRUd6NWZhRE1ZWVl1Sjh6TW8vQnp3cUMwd0NxdWpiUEt5cmhDbUdU?=
 =?utf-8?B?ckJ3a0NYRlpFSzhPY2l4b0dPQTNodm1OUTNaY0tRZVlkRTBmZTBndmJocWQz?=
 =?utf-8?B?WE1ZWE1TMFdhaUNtWTN4SDMyV1VRdmJzWkQwVGRmVVZ5MlpiR1dIbS9XVS8y?=
 =?utf-8?B?YnlhOHc1aWFzbTgrTU9ZTWV5Qldia0dFVjVmY2ZndTQ4TUtGVU1VSUxtczIy?=
 =?utf-8?B?bEVBeTgvRWZXTEZZRmFQVGk0ek85YzNTTXVEQmlZeS9oSGxJTGl4SmIyMU9q?=
 =?utf-8?B?MzRkQUZHNjA1U2k1ckFZRXdPWnhpVm1TZmcwekxhODQ1ZTB6SWRYckFzQUZj?=
 =?utf-8?B?NkJ6QkY5LytXaXZBbE1jYjJFSXQ5QlJKUjlvWmhqaGlBVzFUanhnS0pwL1lr?=
 =?utf-8?B?anZvR1RSdUxSTG1pS3BXcEl3alh5YXI3TTlSZDBkYXR0c1RLaDNHMXI3SzhT?=
 =?utf-8?B?c1JKbERyRUM0ektCbXFjeGxyOThMK045REpEZEZSS0V0Q2lGUk9YV0VXSm5S?=
 =?utf-8?B?Vjg0RHovRlZiTXkwaENmUXJTalVGM0xZcWRwWWlBVmJLaWJ6TVdZMFB1M0Y1?=
 =?utf-8?B?UVpPTzMrVWwvditTT1VMZzhRbi9hWVRqTXdIZkVFWnFQWkZNUEk2WlFJVS8y?=
 =?utf-8?B?UVJ1bk5yTEtESWRWaWZMQmo3R3hzemlENTV4OHdUMlF6cWRBQUQ1Rm9GYlVy?=
 =?utf-8?B?Y3FMTU9iOUx6bDZnMXFwZ3pZMGtaQkNjTTcxMTZxSTZILzhjOTNUOUlDOUt5?=
 =?utf-8?Q?RnBq/Db7DACR9xZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C907B49AB48A34EBF2E0B832E526933@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W+pSb5s56aC+CSUntmFmG2kfbxW3m+LD0PIDM9y8pWB+HdKGioEHf+/GTsMsZjoSOVXEN2gF025zkoGgbxNx5gJ7bu1cD0KGzXwV3UcQQ6olpBH8knkr1z35hN+Bz20bjl4ygmlrUxLMMivKyTga4A/Mnj7CO8G7Rmr2qsJcETvbYnoWrSEmalHlEaYg9synQK42ZKXGb534acx8Aj4erfdDCcmXyEDOsfusZXZNEzH85O7xc6n69vLWWVudAyWVkZ0hZSPfE/EFqzex9hKaOoW6KeWHiXBHtz0cPiEKtiJEjTtfQMrn/oqBYnUyd+ZOFRz0JH1lcBC95Knf5WdNyg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c37a16e5-723d-4b97-c550-08def16f13d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 14:54:10.9305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbERD9ewRsj3pNavETjShBbNFx0NHnyg84P1irzNwAtAgX+jtI7ZFHKQ/Lo5Fwtx3fjdRP0c7X990Nhz25zu6P1XctvqdzLOUD9suG15cCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB2317
X-Proofpoint-ORIG-GUID: OHZ7EU_1dtxxDVVT6vKkUF9myHRgzZme
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX873rtXxhpbRK
 iXKb8wG/7IAy4RpHzK2Cn8ALz+yYesggmy1ApJAJFQOHD03AAn9fYvD/aWO4KL5ceiAE5pINEsc
 wGhzs/m0Ijm1T4SwOtJadJBBqXI2y0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfXzfc+UmCYwPpU
 78zpw+qI6fd36dWkJCfTXnN8lIplFddzEufijfcErBeMXIQBt+G41c7zCf/0Yr04+ZHkHZXB7Hy
 KmGZc4unTHXWTWd1z4ly5PCv57KkbLcpROMxwATKMLMwwjPUe4mKulejE3lH5x5asZa3wpFY86Y
 iP3H4vYIxPvUgQyocXx89dl5UEzqO/nWLo1eFO9SLWNrr3qKZvyzS8yd+fQS/+HiMEir2F4TNOx
 F6a5SiK4ekRrDRzqlw7E2OCMAiAA1qBvGvkGDNXQGDivY43e/xCPaPXyMx8FMMVJUjxxb2Y0seI
 V2XbbCAcYIO9iGcGgK8D0fi/ytFPiQXBI5D1VJA/s94HZ058JjLjBPqep2PcU+Txpa0GoekyLCt
 C6XmQS9t3QRe4HPYcPLzJiMEXY/sPtCEathetkuFnOCNXDgpP2uICdcmGC864a2WmNH5dShujt6
 eoMnTKMumk6pekuDIcw==
X-Proofpoint-GUID: OHZ7EU_1dtxxDVVT6vKkUF9myHRgzZme
X-Authority-Analysis: v=2.4 cv=D7V37PRj c=1 sm=1 tr=0 ts=6a70ab96 cx=c_pps
 a=KeprtYQnYycZG3mihyX27Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=Oh2cFVv5AAAA:8
 a=CiE6kVyt9WuFYCKt4g4A:9 a=QEXdDO2ut3YA:10 a=7KeoIwV6GZqOttXkcoxL:22
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

SGkgUGVuZ3BlbmcsDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkgYW5kIHRoYW5rcyBmb3IgcmFpc2lu
ZyB0aGlzLiBBIGZldyBjb21tZW50cyBiZWxvdy4NCg0KT24gV2VkLCAyMDI2LTA3LTIyIGF0IDEy
OjA5ICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+IHB2cl9mcmVlX2xpc3RfcHJvY2Vzc19y
ZWNvbnN0cnVjdF9yZXEoKSByZWNlaXZlcyBhIHJlY29uc3RydWN0aW9uIGNvdW50DQo+IGZyb20g
ZmlybXdhcmUgYW5kIHVzZXMgaXQgdG8gaXRlcmF0ZSB0aGUgcmVxdWVzdCBJRCBhcnJheSBhbmQg
cG9wdWxhdGUgdGhlDQo+IHJlc3BvbnNlIElEIGFycmF5LiBCb3RoIGFycmF5cyBoYXZlDQo+IFJP
R1VFX0ZXSUZfTUFYX0ZSRUVMSVNUU19UT19SRUNPTlNUUlVDVCBlbnRyaWVzLCBidXQgdGhlIGNv
dW50IGlzIG5vdA0KPiBjaGVja2VkIGFnYWluc3QgdGhhdCBsaW1pdC4NCg0KUk9HVUVfRldJRl9N
QVhfRlJFRUxJU1RTX1RPX1JFQ09OU1RSVUNUIGlzIG1lYW50IHRvIGJlIHRoZSBtYXhpbXVtIG51
bWJlciBvZg0KZnJlZWxpc3RzIGluIHVzZSBhdCBhbnkgdGltZSBwbHVzIHRoZSBvbmVzIGJlaW5n
IHNldHVwLiBJZiB0aGUgZmlybXdhcmUgZGlkIHNlbmQNCmEgY291bnQgYWJvdmUgdGhlIG1heGlt
dW0sIGl0IHNob3VsZCBiZSBjb25zaWRlcmVkIGEgYnVnLg0KDQo+IA0KPiBBbiBvdmVyc2l6ZWQg
Y291bnQgd291bGQgdGhlcmVmb3JlIG1ha2UgdGhlIGxvb3AgYW5kIG1lbWNweSgpIGFjY2VzcyBw
YXN0DQo+IHRoZSBmaXhlZCBwcm90b2NvbCBvYmplY3RzLiBUaGUgYm91bmRzIGlzc3VlIGlzIGNs
ZWFyLCBidXQgSSBjb3VsZCBub3QgZmluZA0KPiBhbiBBQkktZGVmaW5lZCBjb21wbGV0aW9uIGZv
ciBhIG1hbGZvcm1lZCB3aG9sZSByZXF1ZXN0Lg0KPiANCj4gSW4gcGFydGljdWxhciwgY2xhbXBp
bmcgZG9lcyBub3QgYXBwZWFyIGp1c3RpZmllZC4gSXQgY2hhbmdlcyB0aGUgcmVzcG9uc2UNCj4g
Y291bnQgYW5kIHNpbGVudGx5IG9taXRzIElEcyB0aGF0IGZpcm13YXJlIGNsYWltcyB0byBoYXZl
IHN1cHBsaWVkLiBEcm9wcGluZw0KPiB0aGUgcmVxdWVzdCBtYXkgbGVhdmUgZmlybXdhcmUgd2Fp
dGluZyBmb3IgdGhlIHJlY29uc3RydWN0aW9uIHVwZGF0ZSwgd2hpbGUNCj4gZWNob2luZyB0aGUg
b3JpZ2luYWwgY291bnQgY2Fubm90IGJlIHJlcHJlc2VudGVkIHNhZmVseSBpbiB0aGUgZml4ZWQN
Cj4gcmVzcG9uc2UuDQoNCllvdSBhcmUgcmlnaHQgdGhhdCBzZW5kaW5nIGEgcmVzcG9uc2UgdGhh
dCBpcyB0b28gbG9uZyBpcyBub3Qgc2FmZSwgaW4gZmFjdA0KcmVhZGluZyBhIHJlcXVlc3QgdGhh
dCBpcyB0b28gbG9uZyBvciBtYWxmb3JtZWQgaXMgYWxzbyBub3Qgc2FmZSBpbiBnZW5lcmFsLg0K
DQpTZW5kaW5nIGFuIGluY29tcGxldGUgcmVjb25zdHJ1Y3Rpb24gdXBkYXRlIChpLmUuIGNsYW1w
aW5nIHRvIHRoZSBleHBlY3RlZA0KbWF4aW11bSksIHdoZXJlIGVhY2ggZnJlZWxpc3QgaGFzIGJl
ZW4gbWFya2VkIGFzIHJlY29uc3RydWN0ZWQsIHdpbGwgc3RpbGwgYWxsb3cNCnRoZSBmaXJtd2Fy
ZSB0byBhdCBsZWFzdCBhdHRlbXB0IHRvIHJlc3VtZSB3b3JrOyB0aGF0IG1pZ2h0IGZhaWwgYWdh
aW4sIGJ1dA0KYXNzdW1pbmcgdGhlIGZpcm13YXJlIHdvbid0IGtlZXAgc2VuZGluZyBvdmVyc2l6
ZWQgcmVxdWVzdHMgZm9yZXZlciwgaXQgc2hvdWxkDQpldmVudHVhbGx5IHJlY292ZXIuDQoNCj4g
DQo+IEZvciBjb21wYXJpc29uLCB0aGUgb2xkZXIgSW1hZ2luYXRpb24gaG9zdCBpbXBsZW1lbnRh
dGlvbiBhbHNvIGFzc3VtZXMgYQ0KPiB2YWxpZCBjb3VudCwgcHJvY2Vzc2VzIHRoYXQgbWFueSBl
bnRyaWVzIGFuZCBlY2hvZXMgdGhlIGNvdW50IGluIHRoZSB1cGRhdGU6DQo+IA0KPiBodHRwczov
L2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9rZXJuZWwvbWVkaWF0ZWsvKy9hbmRyb2lkLW10ay0z
LjE4L2RyaXZlcnMvc3RhZ2luZy9pbWd0ZWMvcm9ndWUvcmd4dGEzZC5jIzcxMA0KDQpGWUkgdGhp
cyBkcml2ZXIgaXMgdmVyeSBvbGQgKD4gMTAgeWVhcnMpLiBOZXdlciB2ZXJzaW9ucyBvZiB0aGUg
Y29uc3VtZXIgRERLDQpjbGFtcCB0aGUgbGVuZ3RoIG9mIHRoZSByZXNwb25zZSBpbiBSR1hQcm9j
ZXNzUmVxdWVzdEZyZWVsaXN0c1JlY29uc3RydWN0aW9uKCkNCmFuZCBhZGRpdGlvbmFsbHkgaW5p
dGlhbGlzZSBlYWNoIGVsZW1lbnQgb2YgdGhlIGNsYW1wZWQgbGlzdCB0byBpbnZhbGlkLA0KaWdu
b3JpbmcgYW55dGhpbmcgYWJvdmUgdGhlIGxpbWl0Lg0KDQo+IA0KPiBUaGUgY3VycmVudCBBQkkg
cHJvdmlkZXMgYSBwZXItZnJlZWxpc3QgcmVjb25zdHJ1Y3Rpb24tZmFpbGVkIGZsYWcsIGJ1dCBu
bw0KPiB3aG9sZS1yZXF1ZXN0IGVycm9yIHZhbHVlIGZvciBhbiBpbnZhbGlkIGNvdW50Lg0KPiAN
Cj4gV2hhdCBpcyB0aGUgaW50ZW5kZWQgcmVjb3Zlcnkgd2hlbiBmaXJtd2FyZSBzdXBwbGllcyBh
IGNvdW50IGFib3ZlIHRoZQ0KPiBwcm90b2NvbCBtYXhpbXVtPyBTaG91bGQgdGhlIGRyaXZlciB0
cmVhdCBpdCBhcyBhIGZpcm13YXJlLWZhdGFsIGNvbmRpdGlvbiwNCj4gY29tcGxldGUgYSBib3Vu
ZGVkIHN1YnNldCwgb3IgdXNlIGFub3RoZXIgZmlybXdhcmUtZGVmaW5lZCByZXNwb25zZT8gT25j
ZQ0KPiB0aGF0IGNvbnRyYWN0IGlzIGNsZWFyLCBJIGNhbiBwcmVwYXJlIGEgbmFycm93IHBhdGNo
IHdpdGhvdXQgaW52ZW50aW5nIG5ldw0KPiBmaXJtd2FyZSBzZW1hbnRpY3MuDQo+IA0KDQpJbiB0
aGlzIGNhc2UsIChhdCBsZWFzdCkgY2xhbXBpbmcgaXMgZmluZSBmb3IgdGhlIHJlYXNvbnMgYWJv
dmUuDQoNClRoYW5rcywNCkFsZXNzaW8NCg==
