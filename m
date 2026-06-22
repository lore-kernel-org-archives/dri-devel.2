Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CB9CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA1B10E4D6;
	Mon, 22 Jun 2026 07:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVh6Xlov";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E0610E4D6
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px4Hkc1X3RBQUo6oXhvi09Vyax7BaTmFy/0Uh0qnalgiEsESSs+IVpXH4skGXc+rKUH3eCzATuyZZ8ffradc2nJcbY/XDybXIFvdClszsrPClOYZUWn4CjVFaMyM2dI2uZrJJX4SnsHLdyHNwrIpK9pH9EjgaC/m7325tWCi6KB/4CC95VjuhabBxYSVcZTWjyE3WPm6gXQ7zqJpHgM5d2jhQmwCCPAc5VSuRzN4hhqgJGzvurtET6ICUhsX8EmvfyuL3JSukBv9G1Vx2o5kP5t7ASiAMY1tZ5GTf6M92sQ2Iw4As53kdkXNCWusZuaCo2VxRoevUtC0t7At0jm5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny5Y9g1LY0YRJxP4+LxTwPAKg4AIzEv8eAaIt+Wm1io=;
 b=SgnRKq6mFD7lbqjZkw1c2PBxK3PGRofiheACpaYV1TrDqnsXFbzbT6X9Bho8b0evMv3AZ2jeEimK1BfApucrFQ8K55VycjZbjPePNTRRLVEjIv1iiv12CRAdyN+w/khgsfRFCoi+2jfPQgi4nbNuH0xREeNeBfqPmhFLXKiD9t0Ex8ZZyNxgUc2y7HwR7QSegewVZArV5spnq4IvDAoRvByy2r2c7fnBcy/jSKFZ5Ig+jVyzpAVQXpoJKmMRWmYl0k/kp87hKpVtPAy0yQ+lxkuL6/XpPUUwWP8wHjO0QRpTG38C4CsBrPSldI5LUB8EdEWVaZM+B0wSGOO+ber48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny5Y9g1LY0YRJxP4+LxTwPAKg4AIzEv8eAaIt+Wm1io=;
 b=PVh6XlovJ3Pci2EHn3rEDskqgY7CWz6eAmOmer6C0HebqEZdQZsFlThIrOSt1HKCtOlA5J9YYM4bYlc3CZegtLtFaZKfSd1zEDvZXxB8NYQZODDdoPbh73h4ZEieTMkd//yZyxAiZ0EIBJ4LH2zFvAmKp1QAeKAt82dYIH/MdWbwXSxPLi5Gw9UZ/sg9Uy91yAX05tGUoWFCEEvJv8MCpHbxbkE1Hz5FYuQldwHrff0F3auV/+k5DmZiAKQjrl+zdfDwv8nwTj2SKSD4foK9OfQIkx/GmQHNs2HFA606ZREPMothmyGuTD9FnOHzzpB9JTliqYUQV5RqashVet5Opg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 07:06:49 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:06:49 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Santosh BS <santoshb@nvidia.com>
Subject: Re: [PATCH v2 0/7] Host1x/VIC support on Tegra264
Date: Mon, 22 Jun 2026 16:06:46 +0900
Message-ID: <zzSRkXOOSyWrC6y9Zygemw@nvidia.com>
In-Reply-To: <20260622-t264-host1x-v2-0-cdbb730165c4@nvidia.com>
References: <20260622-t264-host1x-v2-0-cdbb730165c4@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a8c40b-e101-4c7e-9c16-08ded02cd46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: aIA+XjkBeMGzX1bQpNMUX6Fr+AKOF/3TV9ZtLfn58zVZzIpbwWkShDusvbNKy5kz0yi+1KiZnEKrHScFxTo1WxQwS3uRSziTGoGXYtHiUCVrOC+CF8eTq+FCQ6ammZqPKv2j+N4Zz7IyTThh8JE64drmsMf1NFbzq+fwGoFPBsHSiEU2DLa6zXZFGM/dgdI6gmYCLfGwtD5AEGWNhK13YnzEqwWBwN3uw1dYXModSUGbIED3RQ261yV7is/DRwB4iS6HMh3PM8XKMVLTAHsfGeKyS+7dg39W812dd5FJul+nhYSWFVbW7MC9QcWTkqJjr2yVl9jR0zkk0Th0+ylTfqdGzVAK+LCnchLH4lwdno9kOrLygg2yOoOXaaUwRFWR86/VTUGESYNOTEs8rcS0X9+KHSkdtNcpFXaeUQyJz/wuM6vkcS49WBPUP/4Va6J7MvAFQBZlIhdsS35oBrfZthUKniTiT+jmkkemzpPNsXiNWNtkNW6molxIqj5SfQqU5NPC5XV3DhpF4HZ0qi3u0GUgdR9nDSuZkhK8FS/4cGqQpOfI+4kl92b4Bv18vf0QU176Qxs+ZPyUaRr/7m+/qJ4hDMXtuDRXklzC9OD6k+DWj+NJzWov3RQZG8/fGv6SUpZ6maLLmaBZfvfkvDREXxRAgtkLlOS1hdCGrPkXYLi4PW6TwM3cPcRsmHbdVvg1xMuTPKZvfozjAvAunyLcdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndDTVdwU2dwV2Z5clBiWSt5OUg4TSt1TzhJbjFBTW4rWjk2b2NIelBmcHE3?=
 =?utf-8?B?b2xUWUVZQmNTZWN0QWFxcExDekF1SkR4SGRsVlJ0M29NdGtUOG5Ua0N6c3R0?=
 =?utf-8?B?ZWo1TEJzK1JVOUVrWGE0NjNubU1KWjc0VzB3bGVzNDk0VyswakpzbzZJODdu?=
 =?utf-8?B?Yit4RzM0KzN5RXlYTzI3ZXo0cUpoVElDOTJ1MTYrMUxiaStIUzVVd2VlTzhF?=
 =?utf-8?B?bFY2amV4dTJFWlNDZ2xKL2RObENVVmlOb3BVaEtLN0NkL1lrUlRQM0txR29H?=
 =?utf-8?B?Wndic2xWdEZXWVJVaGV5SE5uQ3BzTWUrVnJ6OFNJR2ZwRjRUSkdEOVJPQytC?=
 =?utf-8?B?Z2F0T1BsYmx6ZHgzMzFwb0hXZVFYMmdxSWxZK09rLzV1RlJpblhjQVMzNDNk?=
 =?utf-8?B?eUE4aWNDWFBvZHNTbTF0eGlpb2ZIc0gyVXlJMFN1NDJudE1PU0tYOUExc3RE?=
 =?utf-8?B?bEtGUGhJRTZ0ZXhLZW9qVGhUWnpTMVZGaFdJM0ZOek1EaGlMeFlnUG1CdzMx?=
 =?utf-8?B?eHFSdUU5VTE2YlByUGxUcU1peStON20zdjRJUVdRRFQ4cDBnK2kza2ZkTWZY?=
 =?utf-8?B?cmhacTVlRUppelBUazhzdC9jdDdyY0xTcFR1Q0JhWHFsbm8yWTIzT1hrSlB6?=
 =?utf-8?B?TkFhQ1M5dE1ZWVVZQWlXL2NEMDI2NGhaUXB3SWNjb1NCVjNQQlg2RDZGUjUw?=
 =?utf-8?B?M0VKaUU4SmhFVFU3SGRCYWN3N0JnMWpQQisybmo3eFBlT1FqRUdSWm9MRFdQ?=
 =?utf-8?B?Q2MrMFZ5M2x3M1FaWE5SMVVtc215ZG1wYkNFU1E1SWhKcGoyMkhWNUNFcDdU?=
 =?utf-8?B?SUtUN3VTWUpUM21NdnpqQUVrR2RLM2pMazdiRXc5TkVOb0o4dzhpWHRIMmpH?=
 =?utf-8?B?cmx0TGs0SktTempMaFVtUEdhK2I0Tmlscko5M3RxRUY4b3MzZTkxemd0MllL?=
 =?utf-8?B?N0RSMTU3R0wvcURUK0xpRXRBamw1eElWTGFGZlpPTWcxSktXcVhPRVRKamR0?=
 =?utf-8?B?YlluYUt0NUJJV2duRWMxVEdORWwvQjRDUFowMTVTQTB1SEFSYVFLUWR6eFUw?=
 =?utf-8?B?TUZuZUY2YkJtQ3JQSTE2Wis3WGl1Y3NiYUxqU0ROSEhkUVlnbGMyWDJRTFk0?=
 =?utf-8?B?d1JCNFI3ZkEzeW1NOWU3d3lmdk1pdlFMQTFQYnYvRDBBVWFFSzJLVXQ1NGF4?=
 =?utf-8?B?WkVLOEk4ZjFJSEFsQ05scXZFbWdxUWJhRzhTeFhTZW8zc2RaMHA1dm5HRXZL?=
 =?utf-8?B?OHJ4TnR6UUtLZFFxTEwzYndSRjVjbGlvYjdyZDVqbWpSUG5WVys1d0xkdjc5?=
 =?utf-8?B?d1F2eUFYQm94TEU3ZS9yWG5rKzJTeHBlUitES2c1V0IxWnA5MmR6ZHRNSGE4?=
 =?utf-8?B?QWxiTkh4Q1U3Z1hpU21WOEhzV0pDUHdQZFdUdzJwdGZRV0RRT0NBRW5wbklN?=
 =?utf-8?B?NTlUWFU4RDN6bFJDcU55SzlDYkc5Z1pUM1ZHdkxzU1VrYkRTdjZ4YlhWellX?=
 =?utf-8?B?QSsrRWxzWlZJcmZPWGpReFVBK1hKbERtSEhFQWkvZVZxWUtSUUlpeGtuVW1Z?=
 =?utf-8?B?dXpVOWllMHpnZUloazM0aWZHbXRrZC9UZVlLZDJHbkU1cVFiZ1FPVXc1MTZh?=
 =?utf-8?B?T2dpcDdpMVZESnBnSFdaVGttSnZUTUV4NE5qazdKSVFwZ1RZby9XNE8rWC9F?=
 =?utf-8?B?QkxrQ1FZWTNnT1RESnBqWkpNSjI1dWF2WHhlYmF5K3NCV1ZQWE95d2x2OXZk?=
 =?utf-8?B?VTErVFM5RWxTWTNUbk04VUt4NFEvL2RydkI5QnRTWGROQmJLNk83a0RoMVpt?=
 =?utf-8?B?bXZVTGhVVEwya05oUEkxbmpBZndybmZGalZrVW82ZXFudk0vU1JKSlR3OWtD?=
 =?utf-8?B?bFJPNjdIblB2ZnVMNTh4VEdMUDFnVFdSWTF5K1FMU2VrM2Jmc3Fpdjc3ZEpR?=
 =?utf-8?B?UWJMbVhmYWkrS0NaYm9FRkRIL2xoUnF5c1l1M0ZWKzlPTGgzSWZkSmtxNkY1?=
 =?utf-8?B?aHJZcDRSTHc1VjdRWVAxK3JBaUdramZhZUZQdDhtYnNxdkVBcHpRUVdyUlM2?=
 =?utf-8?B?YXo1STBzSzZKbWY1Zlgrb0k1TXRNS3ZzRGR1OURtcTJsZk9zWWZiYkh1S011?=
 =?utf-8?B?THI3NXFyR3dFZ2tQYjNkK294T290UHhUNlJPMUo5UWl1b3ZGdTFaT01Md0Nh?=
 =?utf-8?B?WmRWNHhFSmJ2RGhEYXBkOHdXTkdpK0ZYME9LNGtUMHdpWDVIdGZoVkc3bG1C?=
 =?utf-8?B?THJjR3FNZGRQaWNHUXpRNjVhUXhLL0FIY2x3NnBDQlF0NklXcHdnajUyZURV?=
 =?utf-8?B?azRkcEZyejNUNUNuWlhzTTBDNTM2eloyZDdvSU5sY3dEeHFBRDVCbG5LTmxQ?=
 =?utf-8?Q?c4JZZk3l4GMyvgtemEKteRbjvmuQBJrOhopjyeYsLNOti?=
X-MS-Exchange-AntiSpam-MessageData-1: OcFpH1Dj4DrLkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a8c40b-e101-4c7e-9c16-08ded02cd46f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:06:49.5521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5i0Eo+Re3sLFnWGfVuIptM2M2k01HN9M34W3yr+B50sX0Z8QCdvuKVL20Lh2a6NlWO9HQwhx+AiGAsdtN8thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
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

On Monday, June 22, 2026 3:52=E2=80=AFPM Mikko Perttunen wrote:
> Hello everyone,
> ...

Please disregard this one, email is hard. v2 submitted as another
thread.

Thanks
Mikko



