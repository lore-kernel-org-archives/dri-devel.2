Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD4D3515F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9EF10E96F;
	Wed,  1 Apr 2026 08:39:57 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023123.outbound.protection.outlook.com [52.101.127.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887EC10E398
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsoolBYDEr4VgHR7fpuVb8scJ7vfxmL053EmRAkFxXpl3ri2c0ZkSQSQ78w+XvoAsL54SWSjtODfyUF3rl641UweVcnR/4x3dpWT/oJRYSPTb6D7GMgPkJ5TzDv+Ev7+YlfqMhEbXdPJY0D3Jo+8WL27kMxxNrFH/AZgndZn7ZSNv1GnayPKUbeAZnIk/kRD2/jg+lTVmEfKRmqV4MV+cvooabgtiZKoJbyIBDPUPqA2HmioX4qkk49/okCksXnyle9ZJqNoxYVWOJNEJ0HL+kp2O4t2t2EcNLPmjj1IGlSHGgtqIfModxoc4TRvhvhIGmRe+zYxyqRPKVebMNCelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAYgSed3tuckkwJEbX8YkrOdWN/rm5DGAnFwZpDAj7I=;
 b=nSxUxPxNecBGB9c6c1WIx+Q6Yeip52aMd4bpPf/piqvAcD6yu2eGaY5hCxwVHRT4K4YokqlT4RAvV+/0CMHYr3mHy8f+pVABAjJyECS9icJ3pcLr4WGMeO68S02eIggF6Ab9W18zfBaVnZcPLft+JMbEudpj8wzRyQnCokdkU0rqjveHq6jqsH7SyMTXRvFqTSwj9J2g+rGrMhOmZTwSX+UmLJhDx1Nx6yL813h8viBr8uJWmO+wwlVvjIZATN3RcsUO9bwZ7EqjOUmBMYy960geHZBrxdVPMtVO9FJ51gqNljU52AfPfSmjNdZF1nZJ+4iLkl1AGHKzjZ8Ik865TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:39:48 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%6]) with mapi id 15.20.9745.027; Wed, 1 Apr 2026
 08:39:48 +0000
Message-ID: <1027afd7-dec6-4ff3-85eb-2d9a1646ada6@linumiz.com>
Date: Wed, 1 Apr 2026 10:39:42 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 paulk@sys-base.io
Subject: Re: [PATCH v3 0/6] drm/sun4i: Support LVDS on D1s/T113 combo D-PHY
To: =?UTF-8?Q?Kuba_Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>,
 Maxime Ripard <mripard@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20250221161751.1278049-1-kuba@szczodrzynski.pl>
 <20251116134609.447043-1-kuba@szczodrzynski.pl>
 <a5f6aeb1-b038-462e-8989-c4da65966134@linumiz.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <a5f6aeb1-b038-462e-8989-c4da65966134@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::17) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SI2PR06MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: af6a17a9-e457-4b76-3096-08de8fca3beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ys9d78rSYkMkhr5KZr3X9FORLPqmp9FbJ/FqaZoMzn1wd2DN+UX+I8W13taY2mWm1uzyGyvLPntRNFKoIhu81fe8y9aoQa9nnChC3Y2rbTRSl+1p6lwDfb7aHxQhzRtqvYChaxshBkkHr73oCmHlsX53eXuPfx1ewH4s7A4/JF3Y/QYCNNeNt5YRl/2bGBYn/1rxNG/fbIzJZAgSOZJVZ4JPxySFTK2YCN/PqDmfP9YylC78w/GIFRYxB3G/uzxV26mHkI/RbIzrIsgikwhvMJVYgDaxY1gVtNgBSpZOAZe16v7SxQbPL5EquRFi0wNn4lAOKPDnbf5hyK2duECtRaWdYWYsMtCfXSrDvzSmP0wfgoO/qnndmkAxJsCTvNNnVrl7sO/4Ge3Eix2GdtPwd1HP9ohvjnSUeBQNVKaEvOm1sKAJODAthUYgLaaG2gychOd/DwgjllX0AroPT+s7sg4Am3m/FaNlAsO4LQTXloIfN9jncA4RobeROohlj1tNsO/Y/Xxf2OiffWPhVUigN0MXeC1ctRaEdDabS9b3YQl+JRbsjMMlhZu/ZWyaaDCRs04wkkQLC1UDQzJQHeUQzpyBV1bTRcrj29Vulo6DEjWA1Er0RFvsdY1HeVRqadunkQ4iPFaBEuwiiuS7cXwFA1fbXUcvL5iFAFywhgPIJHZZvb7gPao895+HdberY+AdhZlBZYTeeThUgABwoswHlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVo5OFQ1V0VGWHhJWHFnWklEU3ZvdTVrUW56cG1xSk50RHR5QmYxKy91Q1ov?=
 =?utf-8?B?T3Z4YnplbTgrY1RYdDFzbzF5L1N2dEl4S3M0cExrZXlyWElqalBVUjNVTkNU?=
 =?utf-8?B?RHVodVFRenNOVjRJVzNFMmNpZ25RK3pJdUJIRWRERkxha0VmRHZaKzk1S0Qy?=
 =?utf-8?B?K3NnUWQ0UmRPdHdzeHBUZUZ1Zlp0SXhDT1hrZ1ovNExNNnB2Y0Evd2pDWkdB?=
 =?utf-8?B?d3RSbEE4bFZnY2JkZWhESmEvWnI0Y1lKMGllM1Z1U3EydXJkZ0pCTDQzbzJl?=
 =?utf-8?B?SGRGVzdTTnN5YXlUdXMrMWtlRWlRajBuZWtXZVd1dW51bXJYejlQaC90Mys1?=
 =?utf-8?B?YStCZDhNRXhyeC82a3hXYlhDUWt5bWhWNFV0NnVtWnNvU2lEWENta1hZUkpH?=
 =?utf-8?B?NkxSWStLZVM3SGxHdy9PVEJzbDRxYUl3djIzSE1qME5yV3MwL0lJaVBSdGRx?=
 =?utf-8?B?Z05QVjJELy9IRUE0MW0xcHBsSzl6UHRlV05DYVlnamdOUmQvZW5sZ2dLVFZH?=
 =?utf-8?B?OGtEV1FneFFkdURsL1FxU3NoY0s2SVZ4MjE0S0RwNEh0dWNrMERsek1hbGVt?=
 =?utf-8?B?d1ZXTGlXZDhlODNxdCtkZEZZOGg3ZUllRHdGQVRaaG13Qk81T3g2RmprZFBh?=
 =?utf-8?B?bDZ1TGswNzRhM3hvdktQZFFoNUdJcWxZVTQrL0p6MC9HU1U3U3ZtSGpITEds?=
 =?utf-8?B?cHVPb1pTV3J0QXBYZHREZ3NOOGVKejFTSHB6dGh6djYzRUt6dTFrQ01Vd0FH?=
 =?utf-8?B?NDRNYmFQRmsyeUMvWDBrNTllV21xSmJRTkl5ZW5aYVFRb0dScFh0OXZranMr?=
 =?utf-8?B?RUt4UCtQak1uN2Z1S3R0cFpVVUdSaDZKTHZRNzV1NFMvblAyemw2eWwrM2pH?=
 =?utf-8?B?TFVRRU5ncFZZdnZGa3lTMUhvZFVnYWh5UWZ6RER5Y0QrZWJFVy9vZmpBNjVp?=
 =?utf-8?B?WUdNTllqWlJtUXVuYjZYSW96T2tiRWdXcWwxNkt4MWVwMzVxYlVmWHpsaERi?=
 =?utf-8?B?UnpGQ1AwMmdQVnJTTEdJL01PVG9CL3N1VTZpaUJrclVLRkVtbStrVFljaSt2?=
 =?utf-8?B?Wm5HUmVCMlVCbnB1SEJyaXRpdkdqQmNOc1ExZVJ5YmNBVnJrWEl0dlhnOGNC?=
 =?utf-8?B?N2c5Z0F3ZDlIdHdJb3lHRk9lYlJPb09hY3MxTk5qYThCd29idG5KRndaZXJC?=
 =?utf-8?B?eEFQbkJDb29sVE5MYWRaQjV6RTlwUzFQb1ZQZTJ3NG1ydDJrN0ZQdm9MUWRx?=
 =?utf-8?B?b0NqR2lJOE1EVFNRZmp5UEI0N2pzaWRjM3E2T1V2bGxFUWhrUGdlRXFsMDMz?=
 =?utf-8?B?SUhjODhyNm5GNEVLcVBnTSthekprc3lKN1U3NXExeXFsY0QwRkZJYng2ajEr?=
 =?utf-8?B?UC9sdG1MSkllbHUxREdsWDNvcE5pMjVTWWdpellOd0hNN0RTRE9RekE3OGtw?=
 =?utf-8?B?ajJaWkJtdHdub0ZGbW5kL1NPWXpjZ01UZEJuS1pGYWgzejgzNHJlTFRpbjJC?=
 =?utf-8?B?ekxtc1FJc0hEODYyYVVaNzJsRlBGWmh0U0dZOFY0Vi9UdTk0alE1NnVWWkZ4?=
 =?utf-8?B?SGs4cUZrVm9DVUVqUG5qVWtKN05QczhmMGxVQnZlWko1czZSYytmNTl0MWp4?=
 =?utf-8?B?ZzA5TWxYaHBEQ1BZcStUTzVWcEtidnYrYS9acjQ4YUIxQ2dnUlNvaVFyaFhG?=
 =?utf-8?B?R0xmQmk0ekErMjRSNFlSYnpnYkZ2MjhpRDVnMHU3OWNiVmpMQnJWTDcxUmto?=
 =?utf-8?B?aE5vbG1tZUszQkpHYVAxQng4aUdTUnFTeks3RXEzeWN4SDVpUFhSMDFSS29D?=
 =?utf-8?B?UThmUTE4Vk12UFF1VFVxNm9qUklkK1EvK2Z1cDUzblQ5cU12N1pmSTlENFl1?=
 =?utf-8?B?MjZxQjNweEZOeEszM1pRWWdaTkxYOEszaVpvVDFtR3RWcHh5ODAwZXJVZHpo?=
 =?utf-8?B?WmhERnhOMVlmSlAxakhIU0JzYkNocFhOai9iUUIrMzJjUUV3WUNtYUZtbWNU?=
 =?utf-8?B?Nk5sTllIb2M5R01xalJBWnB3NkpCZElqOVlYb0M1QWc3QU9TUldoOGRka3lB?=
 =?utf-8?B?clh4S3V2dXR6MDVSdG9KV2NhOHhKZ0NmOXNIY3ljT0wxT0xzVnlHck5uck1i?=
 =?utf-8?B?bkVkSXlFQmE0NWZYWkU1OWhzczdMcFZzOHBmMDNZRlNlemw2ajM3OFo0VGtG?=
 =?utf-8?B?S2tvWHo1ZVU3YWhxMndqWWIyanFSY0JJdW1yYnFnaVlocnRYd1REL1VWNE9H?=
 =?utf-8?B?WHBRUXpJU3BoTjgzVXlmeFVRWXdENHBWME9mZC9nSWlCZzVmL3djSU9SeU1X?=
 =?utf-8?B?bk5IYzV6WTh4TytSNzFnbVl1bXV6ZHVibCs5MnoreWFaMlhyckpmbGlsZXgw?=
 =?utf-8?Q?kFnE/PBJnhHyecCM=3D?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6a17a9-e457-4b76-3096-08de8fca3beb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:39:48.6999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1QjUKnUeUHjsl822KJKj4j2ol12qPIUCWuaBc56h2xFhh8EBc/23E2bHjy9s7b9HTYJdbaAZbgInYE8w7C3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5041
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

Dear Kuba,

On 2/7/26 2:34 PM, Parthiban wrote:
> On 11/16/25 2:46 PM, Kuba Szczodrzyński wrote:
>> Some Allwinner chips (notably the D1s/T113 and the A100) have a "combo
>> MIPI DSI D-PHY" which is required when using single-link LVDS0. The same
>> PD0..PD9 pins are used for either DSI or LVDS.
>>
>> Other than having to use the combo D-PHY, LVDS output is configured in
>> the same way as on older chips.
>>
>> This series enables the sun6i MIPI D-PHY to also work in LVDS mode. It
>> is then configured by the LCD TCON, which allows connecting a
>> single-link LVDS display panel.

Now I also have the MIPI and LVDS working together on A133. Can I pick your
changes and post a combined series for the display support for A133? This will
also address D1s/T114 as well. 

--
Thanks,
Parthiban
https://linumiz.com
https://www.linkedin.com/company/linumiz
