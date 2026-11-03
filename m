Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EF606A332
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gV9hxej8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A7C10F2FD;
	Tue,  3 Nov 2026 01:45:06 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2C410F2FD
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm1X8Fr6Kx8qfsDvgKUGK4nX7q7BZ9Q1aQQ0v31qD6/+9le/EN44jENkyEWT9S+5Jh1zmaySIJtCmZhABV3aPu5GyCzxg7J1YpST7PuP/CJbmbtMJwNXdE4SvjJYOinsNJTRIkMSuA7x5bLjk5hcp7zdUJkxhlnK45+qLSTPOwaX3wCoX7FHuKBAmDAJOzxtYLqtInDeKtgo1x4imXh9/HleRFnsTDYnNqdkshLR2jj4fESmf/JAGPcPYlchnT0sTD1w3Tdo+pNipWhec8zGiBUB/zvtomYrmWjY6d6vzWNKOrcSC/Pfu/YXow0ZPwn3r2L8h1vO9XHHb+p6XTstzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3ZnCRB71+gFVIzkssa8e8TL2U37x6S+/GcwXISbseo=;
 b=veyO6CBuXV9XVOoIH1Q3TQ7N12SPxi07zPnDVL259VVGRYgjD4LNj0bpm5WnkiVeTKYQeBRuw5bz9LqoppL9aR7+RD3/Jy/cjdCgcal5UXG7G9gmBGu3BgwGy2U/miBYIE9HBK2+tGQHe9ax+M379qRCsfXNkb/UtBK1AIJEzWYcSG0C30qouf0k1uD0OfqhBu2zhPa0ucX9Ao5AG30IlXcl7HG2AHzqa7S4jhocuztXVkm5IS4EyIoBICf3UG4+9gIy9F9cDRFFbNUx840367d7heo3KExi8Vvn50cejTo0c+uUQS11DikJaLOXo9liM88rWqKGrLgMTFQcMcEPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3ZnCRB71+gFVIzkssa8e8TL2U37x6S+/GcwXISbseo=;
 b=gV9hxej8OCALnKJOhTGLmqXMkbJmWy/wyvzwAEZ18j1y1eB/JOz9wm47Ol6by+GntkNnVChG0+5cWcqkCEID+uSVFkDPp8mwH8j9td4uQ6+01XpsZIVfxxRZ4ZDZVdRUTTBYkFQACKOW49G/NB1CHi78c05SqGtqYH2e+dJY6+c8GPZua8Qn9/JSYw51/ayrzzPRmvKj0uK5TxFwkrtPSz8VAduh7GByeWy1I8rB/xXRhdvzjDDF3gKa35p0evPESsPsWJP5K1lVgRvOgxIzWzHVRS/qIR1HrYXVeolM9lwyoKmXXabH62UdmvFY7VUoUXyrxCrKSnbqtPL0bGvPgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 01:44:57 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 01:44:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH v4 0/7] drm/tegra: Add support for
 Tegra20/Tegra30 8-bit CPU interface
Date: Tue, 03 Nov 2026 10:44:52 +0900
Message-ID: <HUi_TWCnQA2WP19xCg9CEw@nvidia.com>
In-Reply-To: <179362684510.3310106.12424997423646231725.b4-ty@b4>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <179362684510.3310106.12424997423646231725.b4-ty@b4>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:226::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f1837c-0c1a-4401-63a3-08df394c100f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|7416014|1800799024|376014|10067099003|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006|261026121527099003|921020|261009223027099003;
X-Microsoft-Antispam-Message-Info: SJ7f+iR7Do4csI+L2qv1mKd60WFmUrjofdoIi1zwncAfaZXJIg3B0V799P3IKFsZyoR+gvK9uGFLzbcqqxHzXFmN2dNn8n7yx9BQ0E3z14McxulfR+rR7AGHY15Te0Uzf/MzcoU8ugjpoMLa9iMzuzDdV+WkwWiWmYQowGuKZv0js85cRuIrnMWPiMs9yAeVM982PvDq284MCvOnKsFGFnAGpl2dXjJnuZWxsVg2g569DwtsIF2M8bBMDm/JU2Vu7giZR7cbLOgiEW67zQaWawQeSE1G/SsYHPHQN82vgJTIcXHVq45lZ1vsqLtHkW2lUu4SzxTAF+DeKPaJxwfkc6cYgsWMm6sM+hI9WCkIWMyVy5m3qlEts6kSxFpo0aF9q9AiUMBuZhtTXa2K0lNTnHyyhiMEY1D/FVC+Qi7zzT9rgnjgAGkufwWtJjGn6B1swarfFckTesmRAR1KjrrOUz4UvEINm156vShWPIyh2kLdq4Sh7l7FznyQYiIPOLCWD7OF2thn/hcTCq52M1LWmX2BXumzMUEpmnyvt8OE0SGcXmrD+7udU0AsqTj6Xef+O25VOuByKACgX6bH6gtACzRTEFCwbCoz7ifiKCMnIjaYDsrZXjdfnneDOR2sUx+6f4vik/UGSMqKEzlnQ3Gz2RrYRXYW5EnKY3Rnynq8p/lKVYVS6hB8glf0hMGqnGE+0E8KOHQ058o+RrMYBkWsrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006)(261026121527099003)(921020)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWxiaHlVR3R4cWpDdjU2aWYzRWRqd1JZOUVrQ1c3cWtpV3dWVDMyc2QwMlpD?=
 =?utf-8?B?Z3dyV2JONnNzMFJyd1hqVnJrTTd2ZEIyVlowaFRzOXg2OFJhcU9BSi8wOWwr?=
 =?utf-8?B?LzZTYTRka1ZFcTZ2QW5XMlFvcUNjU3lJMlFRZUJDaG1tam5aY2d4dWUrY0Jx?=
 =?utf-8?B?M0hsMWtDQnRLWEVZcllOM0pNSFhDQ1ZIZDh3Wkhoclo1Y2FTbmJ4Z3ZRVE5x?=
 =?utf-8?B?VUROQm55YTdNeU9SWXFzL3R6R2pkM3ovckFHRWY5OExnZUFqVW10UGlDNTVL?=
 =?utf-8?B?NnMyc0oreW45SEhjOXpFQndCQTRCSlJXZk1DY0pxcnpLNURHQUJrcGlNN1JU?=
 =?utf-8?B?RFErMlRkYmNoaENMVmx1TU9BZmR3SWkvQUhFd1ljN1k3d1NzbTRBeXVVZDRN?=
 =?utf-8?B?NGFBZzJ2aVltbVVQczJzN0lUdGlMc3pwNXNXcVh5U1d3NitEMXhQQjhweDcz?=
 =?utf-8?B?Y0V1WHVzNDBDNWR6RDhxaHNIVVFlRU1kM1lVZldRQW16Q0RzSXBLanB5c21W?=
 =?utf-8?B?VHI0R1BXajhzZm8xcjBvSGNzREgvaEEyZXREU0hEbjFsTWhHYkpKNEFCNDlL?=
 =?utf-8?B?TXlDeEtLaHhmUmdVMkVIdFdVNE1KQXYyRWg1b1JrQi9PbU1PNnJKUm8za2Iv?=
 =?utf-8?B?ODFTcmdIcko1MXdjT0ZwY1lKR1laOVk3QjdJT2ZIQzIxVHFwMU1VcFRRNFkv?=
 =?utf-8?B?SXBJVlRXa1JNSHordlRPdU1IT1I4WmFTMmNzRzIzVlZTQWYrSjhMYytDOFlr?=
 =?utf-8?B?eWd0eGt6N1lKdWZlZWFuYWZNVWJDcTcyOWtodVMyN1hDVmpWNnZWYlAvMUhH?=
 =?utf-8?B?SGU0T3pIOEVqVzh6djdmallWTmdHa21oN3pRajRhY1U3Y213YytLWHl3ejhF?=
 =?utf-8?B?MVFOOUlBK1IxTEpybmlzODdENHNuMTl1c2Y5N041SkpYajRXUnR2QmR0Y2Vr?=
 =?utf-8?B?UVJqRFUwQVRjRUY4alpJYjhRZndpV2N1VVZOaC9qYjBtaXM3MGJvWDd0Vlhz?=
 =?utf-8?B?NS9WSlg0MXBLaHBkTjkvaWRFb1JtZHRRbEY1SmNmZ0lRd1JubXlwYmFWWnV4?=
 =?utf-8?B?K1g1RlJqQ0VuZm0wQlBBU3krWFk5b0NRUUxWak5LQlFENWQvb0lKWExrZ0pI?=
 =?utf-8?B?N1JvNElVMHRkc0xHWWZ3bVBoU3JxSFVoUExBU0ZQWFJ3b3ltSUcrSiszbVUy?=
 =?utf-8?B?U1NuOG0yUDBYVWlrN1NrVWRFcW5CWWFqYUk3R042QWZxc1FXZjhIS1l3WGly?=
 =?utf-8?B?NUxuWGpCRGRaSmhaQm1WeTJML1gzSWZBMzNZTm1ERnhXU3lpSzFuOWpSM3B5?=
 =?utf-8?B?WkhDeHhlWjl0ZWdYM2NBSUJFTFk4T0VwWmxQSTNQN0lNWXlwWkFHSnhidnFR?=
 =?utf-8?B?OStzQ091VEVKUWdxKzR1QWFmU0FjMVpHTlJQcEovNTlBRkFLS21JRzhENjB5?=
 =?utf-8?B?K0JKdlRWc3BhL2F6ZnJhT0o3QW92c3JzcDNEQkNzY2s3QllldTVOWnF0ekJh?=
 =?utf-8?B?R1Ftemdzakp2WDRmYmZxdGtkY0N2RWdEZ2JlWUhNVi9OL1p5QmRTMmYvN3pH?=
 =?utf-8?B?QksyWHN4bXArMzBWUkRmNHRnek5iV2pwSnFCZ0xvak5YWmdKWjgxZDFUUmtQ?=
 =?utf-8?B?UEZKUjVENWxaMGJlMHgxZy9Hd0tRa0pZQW54UFBvL2ZWbVBmVThaWWhhSEtt?=
 =?utf-8?B?SHRHVHN0TlVMZFVQSG1vUndGU3J0SDZKUm5Tc0M1UHVkUXJQZnlsSkt6NEpl?=
 =?utf-8?B?WmlpZjF1VVJnMW4xSU1VbjlFT0JCL3JTZzl6b1BFQjlHcWl1MWsxWWIrVTQw?=
 =?utf-8?B?cUlYbzVuMlNpM2orZll4aEpuL1k4OXg5VEQreFYwL2VIMXF3OXBGNFdtTXVo?=
 =?utf-8?B?UmVzQ3ZkVFlxNHVrWFVDQk95UzVuK2FQdzlFQzR6S0FsN0dtT3RxeU5QUkpu?=
 =?utf-8?B?WFYzbWxDYTNwQ0lPaE5IeWl6eVdTQ0NPamhjTnV5YkcrdUhRdGJCUmp4R0Fq?=
 =?utf-8?B?QUplN3BkNFFiL2JZTzBCVUJTZFFibUwxcUR4RTRkQjJBY2F4VVpMaGV6Sk10?=
 =?utf-8?B?cFNXY1g5aHlLWFdRZ2JBNEFLcXc4ZWxkb256NGdQaXlIUmF4dGY2YjZrS2s3?=
 =?utf-8?B?WU5qSG9LUFJPeVJqVHJKcHR5N0t5cDJNakVuVWs4WDRoamF0VUk1aUx1V2I2?=
 =?utf-8?B?a2RkYXpLMmJ0ZTFpNmpnM0RmOGZWMjZMRGJQWm1DVkgwWW45R3FTRzhFSUdj?=
 =?utf-8?B?cVkxZUY3d2QwQ0hXSlpXMUxSR0RGanUwUEwrNVNMbnE2TlpQNmlCZFp4cnJO?=
 =?utf-8?B?WU50NlpRMmxkQzU2Ukw4THlvQUorKzY4NFJFZEYwOEloRmkzdDk5Vi9IdERy?=
 =?utf-8?Q?q+R9NyvbHDxKOawA4+Se1KuH+6ediveIWBgTnUlZc0pgN?=
X-MS-Exchange-AntiSpam-MessageData-1: 0D08WUBIdlmLbg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f1837c-0c1a-4401-63a3-08df394c100f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:44:56.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6383DksoJ3K/ZY5SyUMrA0SEXfngmqYAPC5XfxSbZ47hLt7fj6jyeJ4JEJ/ipsDf7rS+IIM2+8isnnzlllSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, November 2, 2026 10:40=E2=80=AFPM Neil Armstrong wrote:
> Hi,
>=20
> On Thu, 22 Oct 2026 16:22:52 +0300, Svyatoslav Ryhel wrote:
> > The display controller in Tegra20/30 SoCs features an 8-bit SPI interfa=
ce
> > that closely resembles the MIPI DBI Type B protocol and is referred to =
as
> > '8-bit CPU'.
> >=20
> > Add DC parametrization options needed for fine tuning by bridges.
> > Add 8-bit CPU interface in form of a bridge linking to RGB port.
> > Add 2 DBI Type B panels used in LG Optimus 2X which work with
> > the 8-bit CPU interface.
> >=20
> > [...]
>=20
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (dr=
m-misc-next)
>=20
> [1/7] dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG =
LH400WV3 panels
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/46011a636fd=
729c99781533e265297748b5a0b0f
> [2/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9fe804e2a30=
01fd024c0809678d09c5e0ed359ee
> [3/7] drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d87ca1becbb=
095b6204cf657508c91e5e995d9b5
>=20
> --=20
> Neil
>=20
>=20

Unfortunately these panel drivers are not functional -- they rely on a=20
contract with tegra-dc that we've changed in v5 of the series.

Mikko



