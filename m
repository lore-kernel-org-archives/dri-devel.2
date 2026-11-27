Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA1606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EZf4PgnV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC3B10E4F6;
	Fri, 27 Nov 2026 12:35:16 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C9110E4F6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omPNGJzvfqIrViHsNAmGSLSqAj1zyqb+4UC1z5HbosO8XkMNvEP7JDjHQ6WvMhhUxt0xtVKGuJfXrWgDt7nX5sXsx2FaAbDhEaNKji7QkEqTJc1yKejsTRsNSiJrPR3Z50ra0Zi0J4YiOL/xE1i0iz3aemq/9j8Zv1svWRN9tDV7ARlE8t0FyUMChk5UjG37W63lhKjOCnSUqvS8AiFyTXzgTQ5BchAsnzWpuSlusWysVFBxva548GO7q/HAxxQgppdSgy2ma0qF062k7BWT8Ig2PCKDOWJFqxl2EW3ynGGdQYwI7yIE7R0g/jos0IBV9E3+KZXp8xz3661274p3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqLZ2oC58Nj9yfPkawFj9xUxgmB5AsDXw/vcACqmsQI=;
 b=dkbGwgY6VJ12yhAaKrBeUwj8gsHEjEpkuuKqTSKBQ8WqAnXcXhufT/LouHloQeHfv3wUZlpduphc7BvCX1IMOQt//NkOIOSj86DRlFBM1+GTLl7Is0PY2ECvZ2eXka98n3xxiHPQMcuxryL98Re6WR6K56IwODG2LSEYKIQeSBmKSoRtcT9l5XGM94yysXdMK3IiXLEsXRJEHmJdFcDIIujQYlvlEpKjb4yTEyviRk6zp1h38W1n+3sU16N2xf6e4cNMRkiTEi0swWL3r5SAWW7B/m+N/45tKp5XjCOcR26zcv2fqWstDM32O5w0/TzDYvKFIjp7UWBUVD6INDNE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqLZ2oC58Nj9yfPkawFj9xUxgmB5AsDXw/vcACqmsQI=;
 b=EZf4PgnVeobat02bbSRpfWIwlzv+Sw0zMV+xAVX1gzMWCj5XzazZEa9FmL5lvKuM855S2BUPnTdk5UGij1Ux5motniTau4PgJ7lLscszrz34WulaYZq/mOukVO/ZQE/IsCJiRuddBtNJ+veHcpYKRtM8KfZG2kpK+yhUGVFoRERwZGgQIPemcv7EYbSQODJLInz3Dryes+hRqHSDVCoq4DDMDYVLY+Y5sDll/1WiEomdZsX2/RL6W6dkZ6QV5AaLx4XeGL/KcG6inF7PE0CmzDP/B2IMMnMZ8SL8aiaDPWcN9/WegqvwR+qEwgtFyWCS6mhIw7vDYeuj4wppf2XOsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS6PR12MB765380.namprd12.prod.outlook.com (2603:10b6:8:411::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 12:35:06 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:35:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
Date: Fri, 27 Nov 2026 21:35:03 +0900
Message-ID: <QEeSnm4uTjq24quMQBzlfQ@nvidia.com>
In-Reply-To: <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <XPGRUNopQCaIq1yDhISpSg@nvidia.com>
 <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS6PR12MB765380:EE_
X-MS-Office365-Filtering-Correlation-Id: c4834f6d-0ccb-46e1-12e9-08df4c82dddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|10070799003|366016|1800799024|376014|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: TXgxvKVFZUzJLdVVa/Rg0yy0up+AWTHsx381Q4MG6EC2pZrd7cBZ9E8QZunDNkmYzo+nlelAWA5uSMXFjKhR1gVDN9KhbZ/73GZx6sQj1F6bJtjNTuq7o7Y2fSxYtfc0LJwyNretpRfE4RW8n+tvHIL8oQqH9UvFYYgK7Y3bxfS4C9zeWpaiXPlM2KXJ+BhlP3lIzF6bdie6zsl4/N0tgOdIrJhTfX4h8Fi3hiZWsNOjYrEupVdQm+y7+0KmGgnY4hAzE4DehuIKFZMsuBjf7pmq4j1mZ7AqbkM/0yQ3bXf3dAr5jyhD+6PtUGRRSGYeo3BtNh/sr7ZSYmTJux/Og1Jx94/i/yYYBgZm4nXy6egW4zspuQeFhLJx33G95yUZwwnJxd66lpPwUdVBxd4YDNDdYGvPaRO5+mPzreMriFWLnMjRyu59XN3m7jte6EROjRL4C5dak8moaka/FnBrgLmoGGnJTBcK9rAR2HnNNqdGuL0rB9MnqKLGWBRJBTxkDfWqdnO0M8G9y72CLodkcccC3tE8538ZX+ULPdRl2KzHMsgrmdbhzd1JAxumlaO2pUPrOveVlcP9Jr0X4cvYdS285GrsNsbM0zVTjAUoYc+yoUovhCIHqSKzW+3MjH5KDLPG5O0SVRcU9A9HyQshdYZIVkJ3rOHYI20HZKFDOjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(10070799003)(366016)(1800799024)(376014)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVQyUW15MG9ibXNLMWdEVGVDbVFvTXNoaHd1ZzVkWFpyMXhoTGQwWVpEUlk0?=
 =?utf-8?B?QUluaitkak04RGdwY1Q5WHN6MmFUa0NnT0YzcDB4ZGZvMnQ2dW5USnVrcXVZ?=
 =?utf-8?B?LzlzNVNKckQrQ1BaS0VlcVB4RXVqaGpkR1A0VHMrL2ZCSUZiVGpUTjg1b28v?=
 =?utf-8?B?V1kvcU50VXJ1UXZIVmZHL0JYaUhTU1ZuN0dLSXRNRVNzMmkraWtocjZ1VHpp?=
 =?utf-8?B?QktvdHI3MjdwVWY4WHV5Qk54V1NqbVY2Zm1nZlR0cTZHdFpQaDF5YXFQaEpP?=
 =?utf-8?B?RUw1bHhLeUp2MmwwWVVnc3BmOXM0dFhJVEJqWk9QVFdKN2VoWU5PRTllNnE0?=
 =?utf-8?B?NGlKOVAxRFRLMzNQWlQ2Q2tnUTdzVXZQNFpBYXJGZGRkQ1JRVnVqSFlLU2ZF?=
 =?utf-8?B?cDZRVXd1QjFtUGxxWFNZUEdHeHIweGVHSWkveFJDSVEycFNWT1g5MHQzYXZz?=
 =?utf-8?B?UG1lRWtEUDBGeHk1bFNhVTI2cnJMZkt0RXorYllBU1dqakNsY010aHJ2SEZR?=
 =?utf-8?B?TjUvTkZHZXE2VmptbzBPZXlXazJLSDJDVTFJQmp1ZGZGZjE0S2toM0R3UEI5?=
 =?utf-8?B?WTR3ZER1aGVaQU4zRFR1Z3BvcXdhQkJ6RTAzK3gyWFlFUElhV1VwZVlNMmhl?=
 =?utf-8?B?RUE4MVpCV0paVTJwMnhHYjVONHh3VUh1QTVQd2dOQlpNUFRQOXpmTmNrS3dL?=
 =?utf-8?B?NktqK1g0bkFSRU5reWVTQzUwWVFZR2h3VnN1RFQ0b241OXhEWlBVbHdBYStm?=
 =?utf-8?B?S09RNWZFNjFWMkoxcU9ubWlCblYrdWR5ZitPTGtXSWtIM2lKOW1xcE1ENW8x?=
 =?utf-8?B?d2J3eWdaMmVCTXp0SDZXbkxkYTBBYnV4NXlLWnQybXk1L0dqdmt5Z1pXMGtT?=
 =?utf-8?B?Y3VLRVIxOXJxWlU0bFNwYlZ4bUl2anhtdTM2WjJmMy9kVlBya09zejl6YjBQ?=
 =?utf-8?B?L3RmWWxMZWNlU3JMN1JTMUxsL09KdDNoeEU0bEJKOEprWUdObW5tSStIcnBX?=
 =?utf-8?B?MzFXZ3FlYWM4UlljQVg4M3V0d3RyY3NTUUNYTEVhKyt5UGV2aEVjVnlXUWNm?=
 =?utf-8?B?RzhHbVV4Z0w5OGdESUduazJPbGNBenZObS9SRlFqYnFCQlRzWWszazRjTjRM?=
 =?utf-8?B?dEcvMlRwMmZORnpiMmFBa3JYYlpVUlFodUtxdDk4Sk1WZ2RGbnhFRDRPUnBa?=
 =?utf-8?B?UzhidzRaZUV6WW9GOGtNTnRHUktpUUx1R2VhdjFNcS8xMmxFWi9CRWhObHBL?=
 =?utf-8?B?TGRUKzlrQWxITW80a3QwYXo2clNWcjUrazdDSG9qbi96blFuR0o1Y0ZRdTJF?=
 =?utf-8?B?UUZnVUhtVzg4K1RrRWhjUjNGMWoyUHpDaldPUnpxNHpxeXlwVDN0dmFWRUxJ?=
 =?utf-8?B?YTd6MzNDVkR4UGUwZTBraU5KcmZOQ1UyT2RtcXJPcUt5QzFjRXUvbytuVUoz?=
 =?utf-8?B?eDdMUW84UGQycU1OL1BSZVBhM1hvT2xXUWpGOW8zWUZhY0Z6Sk8rOGhPWXQ0?=
 =?utf-8?B?VUVYTko0dENqWGVHV0NDWTZLTysyUjQ2ZDZ5bEJsSmdVbEZPSkV5UVpGa0dS?=
 =?utf-8?B?ZlpPSHVvVk84TEsveWNVeGdoMnZpN05yd2Ftc3ZwdkNVUTdENGxjalRsK3R0?=
 =?utf-8?B?b1FNdHlqNGxWNXhZM3RpaS9lejJma0Nvb0hIUjlhemtDcUtTMkd4ZmU4MVlZ?=
 =?utf-8?B?VjZZSlFXYlJ5UjZWT2tFenJSTCtjc09US0YvTyt6SVBDckZUVVpPVE9OL3pa?=
 =?utf-8?B?c3JOSGw5NkI0TUpGNHhaYkZNb0IvV1RGZXJlU0QzWG5xTjdWU3RtSFdiRVNs?=
 =?utf-8?B?R2xXTDAvT1EwcVVMbGZheGx4aU9RbzQ5UXhxbTNIY1ZaeVVZZEJmUFNteEls?=
 =?utf-8?B?MVpOd21HSmNMMkp2a0hpcHJHblZrK2ZQbGs5MXBGeXdQUlRvb0hhaDNEa28x?=
 =?utf-8?B?MUVTUnBiVmRUV0FidE9MWHlkM2xvdkpMUmtkeERkRVFZT0piYTk5M204M0VC?=
 =?utf-8?B?aktMd0toRlRmOGlmcFRHN2RhbEt0cG1ZSFhOUDhXcEdCUmhVQXN0UVJWT2th?=
 =?utf-8?B?ZjBzZlFBUDVabytxU0FhSmFvdlZNR29EakpCbUxTY0QxUFdUenFpQkNlSVVq?=
 =?utf-8?B?a0d0bEo5YnRKV2x5Q2pydm1HbUxWc0J6TzlVVWh5Vjl1ckN0a3p4d1U3d0hK?=
 =?utf-8?B?S0FWelRyMkdMSjhyR3ZVT3dRcDU5WVNvWVM0VzJEeUV1a1M3WVNpOG9EUnM3?=
 =?utf-8?B?YnRrTUhXOFp5aUxqUXNEVVhOUjZNeXhRMEtOZkNKMnhLM3JhSUlhSmQ3NWJ0?=
 =?utf-8?B?djNrbHhaV3JraEtQRGpleXlpYXJHY3E1S2VzQkFBZXhKNkx3UGtiWlBxVXZy?=
 =?utf-8?Q?ix+l18QrXHeax0azYfjjAPHzzDY0Fx377bwiT8i9LhHUe?=
X-MS-Exchange-AntiSpam-MessageData-1: ZR4oZWr/mdLBJw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4834f6d-0ccb-46e1-12e9-08df4c82dddc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:35:06.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRwCcUl7ioYciCkk1rWT/VRuw2fe6rnzH5dCXvhQlCo47WD35OEa72L/kL8Tyq/wSaa+W667scoGgbmerEb0Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765380
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Friday, November 27, 2026 6:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 08=
:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Parameterize configuration based on bus flags passed from the bridge =
or
> > > panel. The list of supported flags includes now pixel clock polarity,
> > > display enable (DE) polarity, and data alignment.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.=
c
> > > index d48d498068ac8..faecd6f94359f 100644
> > > --- a/drivers/gpu/drm/tegra/rgb.c
> > > +++ b/drivers/gpu/drm/tegra/rgb.c
> > > @@ -5,6 +5,7 @@
> > >   */
> > >
> > >  #include <linux/clk.h>
> > > +#include <linux/media-bus-format.h>
> > >  #include <linux/of.h>
> > >
> > >  #include <drm/drm_atomic_helper.h>
> > > @@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct drm_e=
ncoder *encoder,
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_rgb *rgb =3D to_rgb(output);
> > >       struct drm_connector_state *conn_state;
> > > +     struct drm_bridge_state *bridge_state;
> > >       struct drm_crtc_state *crtc_state;
> > >       struct drm_connector *connector;
> > >       struct drm_display_mode *mode;
> > > @@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct drm=
_encoder *encoder,
> > >       crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state-=
>crtc);
> > >       mode =3D &crtc_state->adjusted_mode;
> > >
> > > +     /* Get but flags from the bridge state. */
> >
> > s/but/bus/
> >
> > > +     bridge_state =3D drm_atomic_get_new_bridge_state(state, output-=
>bridge);
> > > +     if (bridge_state)
> > > +             bus_flags =3D bridge_state->input_bus_cfg.flags;
> > > +     else
> > > +             bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> > > +                         DRM_BUS_FLAG_DE_HIGH |
> > > +                         DRM_BUS_FLAG_DATA_MSB_TO_LSB;
> > > +
> > >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable)=
);
> > >
> > >       value =3D DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
> > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
> > >
> > > -     /* configure H- and V-sync signal polarities */
> > > +     /* configure H- and V-sync and pixel clock signal polarities */
> > >       value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1)=
);
> > >
> > >       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > > @@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct drm=
_encoder *encoder,
> > >       else
> > >               value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> > >
> > > +     if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> > > +             value &=3D ~BIT(PIN_LSC0);
> > > +     else
> > > +             value |=3D BIT(PIN_LSC0);
> >
> > I think this is the wrong way around: SAMPLE_POSEDGE means that the
> > pixel data is sampled on a rising edge. That is, it should be driven on
> > the low edge so it's ready for sampling in time for the rising edge.
> >
> > LSC0_OUTPUT_POLARITY says that the value "LOW" (a bit confusingly, 1)
> > corresponds to a data transition on the falling edge, i.e. sampling on
> > the rising edge.
> >
> > Section 31.9.6 states this a bit more clearly: "an active low pixel
> > clock means that the data changes on the falling edge of the clock, to
> > be latched on the rising edge".
> >
>=20
> DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE =3D DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDG=
E
>=20
> Should I replace with DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE?

No -- with the current code, let's say=20
DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE is set. I.e. the panel tells us that=20
it will be sampling pixel data on the positive (rising) edge.

LSC0_OUTPUT_POLARITY will be set to 0. The TRM documents the value 0 as=20
"active high", and "means that rising edge coincides with data=20
transition". That is, the display controller will change the output pin=20
state to color data on the rising edge. So the SoC pins will change=20
state at the rising edge, and the panel will sample at the rising edge.

But the pins will take some time to take their new values, so this might=20
not work or could be unreliable depending on all kinds of timing=20
factors. So if the panel is sampling as the rising edge, the SoC should=20
be driving the pins at the falling edge, that way there is time for the=20
pins to settle before the panel samples them.

So the value written to LSC0_OUTPUT_POLARITY should be the opposite of=20
what it's now. If that breaks the panel, either it's reporting the=20
incorrect DRM_BUS_FLAG_PIXDATA_SAMPLE_* value or something else is=20
incorrect.

>=20
> > > +
> > >       tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
> > >
> > > -     /* XXX: parameterize? */
> > > -     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
> > > -             DISP_ORDER_RED_BLUE;
> > > +     /* configure DE signal polarities */
> > > +     value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(3)=
);
> > > +
> > > +     if (bus_flags & DRM_BUS_FLAG_DE_LOW)
> > > +             value |=3D BIT(PIN_LSPI);
> > > +     else
> > > +             value &=3D ~BIT(PIN_LSPI);
> > > +
> > > +     tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
> > > +
> > > +     /* configure DATA order and alignment */
> > > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > > +
> > > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > > +             value |=3D DISP_ALIGNMENT_LSB;
> > > +     else
> > > +             value &=3D ~DISP_ALIGNMENT_LSB;
> >
> > DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to check
> > here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB/MSB
> > bit ordering in a classical way, instead:
> >
> >   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
> >   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
> >               R[7:2], G[7:2], B[7:2]};
> >
> >   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
> >   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
> >
> > I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> > panels depending on the layout. So the correct value depends on how the
> > panel is wired to the SoC on the board. Hence, I think we should
> > describe this with a new property in device tree under rgb/dbi or
> > endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> > document that this means the above kind of wiring - not all RGB888
> > panels use it.
> >
>=20
> Ugh, why is this so confusing...
>=20
> > > +
> > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTROL)=
;
> > >
> > >       tegra_dc_commit(rgb->dc);
> > > --
> > > 2.53.0
> > >




