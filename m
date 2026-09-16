Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6E9C88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C51310E2F3;
	Wed, 16 Sep 2026 03:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X2oM0Vt7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AB710E2F3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwTpPQrrov8EU0h9qiRJ8oT4KdNMKHb1GssoCsMtSu5iUmzMDt5ovHbiTTs76ux2WPRxkYDNZPcgOb2CnF65FWsAF6ofWgANLkv/OkV/wqALXIV6rRfLcdcivcvXGfZS3Vg+Llyc/njyY2y6vobJcXl2HS07u95t80pJFqkbqYeASasZ1C9d9iPMKieY5BC6WxP/KZtCx/ERmP734MS9jNdEGkmcefr1wNMRHNrVPz8sp5Fo6WvtLDYHfgbvMUfzzLvSXH/N6PHkqjlIvhRCA6C/EW9dp3tkghrdyG0bbV9XLqgJOuEpEXJskQQliNCTPqHUltUrKUzh81RUmAdvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v9LL/MFIwB8zAscmw1HaajsV7ej/HuFE/o0cgon93s=;
 b=YwD2tN3bftTliGTI23RydLbXtBF0d5QWlsTBPYajpnS/kCnz8IKjaFbTs4hcayUCQBPx/2M1KIxEyJGD7Qg9CEJBgIgc1oAtg69u+Ltzf3wkSz8UBYciyBvUInAKdtWMKgJAYGLPVlRcbexqecBg+gtZWzdO1+xR2VsY/3JlCBKDdeWON1NJRAlPXfArlzNQjRw9S43LA+wScoBebntyU8+Gn4NwtG48NkkFednVUImvL66utJqvuJy28lYoCIg8RUuXJ243cTOmRorMbzAWEy6Msg65L6G3+FyoguUBHrKjVbz26L5q3pss0sWDgrnciC7D/Y/WQGfACvndQVpg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v9LL/MFIwB8zAscmw1HaajsV7ej/HuFE/o0cgon93s=;
 b=X2oM0Vt7oU/SN7COJNnkzc0EVlYTc2rJ1NUJf4NHMQWZrZggQtxg1vnCtNQY14OYHYypR5CoME0f8eH0eHN/iBmxqV3TnDAaDIiXjrspbXRSEvBMZKgSOq+V9qdES5Vbtwq78oX++A2r7X6nznDA42IdB4++osbzgNXixq/DQV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF37951B1C9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c6) by SN7PR12MB7276.namprd12.prod.outlook.com
 (2603:10b6:806:2af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 03:38:18 +0000
Received: from SA5PPF37951B1C9.namprd12.prod.outlook.com
 ([fe80::2ebe:b9c2:13f5:89fb]) by SA5PPF37951B1C9.namprd12.prod.outlook.com
 ([fe80::2ebe:b9c2:13f5:89fb%8]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 03:38:18 +0000
Date: Wed, 16 Sep 2026 11:37:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian KKKnig <ckoenig.leichtzumerken@gmail.com>
Cc: christian.koenig@amd.com, nat@pixelcluster.dev,
 arunpravin.paneerselvam@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
Message-ID: <aqoPFhvMDvfGGh7X@amd.com>
References: <20260915154804.605772-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915154804.605772-1-christian.koenig@amd.com>
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To SA5PPF37951B1C9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF37951B1C9:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 609ae73f-8752-41d8-0769-08df13a3f282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qM1LsDxTtsGFgfQ9YfL6h3dhSlT1Hi978M8QGoQaJlV6gv7j/+b41VEvhclSJLWF7xG6HySssZfJBj6/gxOUykLLehY37ycRKGbHR924UUayTz+M4b3s7j1YO4U/E8ey/MJcsnEVXTF3VQa8hgee0Pab5P4bTVMCoqTSLA6Kv0zISQopb/IBl4oe2k4jNGUde+4uQ4EJArPmgGxPH9t3hlymo5cpMP23hLdyHk3DM7W1GRy7p0mHvmjchiTmlFEKRwRC2XFOIP9g3pf0sP0/rB/ElIFIh/+AShrV4bZK3oHkRqCl58gwIMoxPSdr7NYf12AQ+PXrUJdFzhrGgLehTnUAkgWT1v+/TAA1cPOdrFP4rnruy75WePOk824Gm0CdbiDb/3CiEb5vNsbdN5OyB7bnvQnI+GI4YWKhWxEep+vnQ7Q8idTCXq91MDPHi8sP+DnRueuP4xx9hBulXFEUI6m8rL9uvyR6wsEUHZ0KuKozob5OhCvKGYbzRUcDP5JgheMr6QiS6D5vPxTevP4uLQEj0XhyHeWvCh8Y1imPeSOLNm9jgeLAfcpvioSaQg4wuUkwEefpIhidk8kLpi/xaofJyWweHYHXv6BVIrX1iLHHXgUReb0G08THXl4moCEr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF37951B1C9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5vo+gkbZ9sXGo5meDtrTcVV2teYz90IBHNovMNsgGLgJnlJRozspPWnny8?=
 =?iso-8859-1?Q?pNzWvIc+zUd6NadJkOe4X71yWrIxDiTlogKhIaYzkRpckGnCKNiQk/wAXw?=
 =?iso-8859-1?Q?++uosWngpnujKiahoIpOtomHSrr2EpMCsR39bqw3vQ77iqy18qDIciXa9S?=
 =?iso-8859-1?Q?Wg1dX5CP7BMOxOUvdh/g7rWCAXhw1CiaajROqUNZnGG/flAL6fWLMTtYAy?=
 =?iso-8859-1?Q?EVnCzfBH48xOPLu2HH4ZxsDixZ8pYIGjRgMCRzJI/SAXkIbRTK6Uqm7E+C?=
 =?iso-8859-1?Q?oVc6u8FmyM/8zK0+2cBilvhV0SDqe4w/yLaBB8aRGurMmiTuOPvlG997MS?=
 =?iso-8859-1?Q?JUunIzHfmhs9JJBmRV/UJTzaeTiUz8rCGEwB500z5O3FB1UbwUQgRKvgBC?=
 =?iso-8859-1?Q?lzfJ7BLZgXjpAjwB/QzKGvQp/AFfDqKP24pX38LYDAPB7Q0yR9v08FqpI4?=
 =?iso-8859-1?Q?zj2kgPlgcHrUWZZbIBPpw9SZknyO+CZcrMTedNPqI9mRW/DrimutrfCKFF?=
 =?iso-8859-1?Q?AF4m/APTFHu7W+Gxx4NJMJjSwIu6nlMboSHXQ3XpSYA3DnjaYcK9UCeYuU?=
 =?iso-8859-1?Q?3W5CzC4N/LaiXp5PBMTiRQ/34S+VUR5oNjvASr8/hXGhWmGHeGMj1iqT8v?=
 =?iso-8859-1?Q?RJ0urCj4EWBaSSpYaXcQ1QW2bt8CCztAuazBmOQ1sRrszJY9/oKMQMFwu/?=
 =?iso-8859-1?Q?K3wP18/CtyN0rmQK4kd8pB6cYohh1lv39NH3Dormm6Q4YzYzv2aXd/vooQ?=
 =?iso-8859-1?Q?w4BeJTI4rItONFwqsj2v5px366oOrB22ozXBC//4l6AsLnggxHfvoME0h5?=
 =?iso-8859-1?Q?5/Ff6HR67379olep8afl3Qc8qPG4aYcydSYcseCMObZyM8uY+vdCyT1wjV?=
 =?iso-8859-1?Q?nyraZmcoqfHTGVueYhSNevuk4s216SBOb7j78dmZSmIF8AIcGa9jhAzkNY?=
 =?iso-8859-1?Q?Gfr5v5n/Mew6fQ4wWMVe6Yrhqaba5BIaVvSMsEeZoB7oZ/YLUOhuIyWRBO?=
 =?iso-8859-1?Q?S5UMlNJIbw6twyWqWKO27IcrzoLWODfeJ7Iazb0RyQj5vTBXmv24Ybdtnt?=
 =?iso-8859-1?Q?vWgN1SrqQ5xrdBbwD+wVxgD3yh10q3ElvwGxnfXYBbUdFQOZyo/5Zah1B3?=
 =?iso-8859-1?Q?URGYIeYMi7vEMcsrPmDGC1ZhtL0g4Vl+hG/GEkYs4KaDYvH+kOop0lljpa?=
 =?iso-8859-1?Q?BLKkm0WXG/ACMIkjvKd8vhkbsXeSJPaehBXcTvgc+mk/6krnERr1kuQgcQ?=
 =?iso-8859-1?Q?CM5g7D0ugClAAm/0byEcrPRlsbonL1P3ee+dYev0Cz+YSrOo7uMB8LjArh?=
 =?iso-8859-1?Q?YM48j3eRL98i0notqVqL+DhRUgvcjZdpe3nO7wN/OGezSzAssOpzz1aUog?=
 =?iso-8859-1?Q?U6U6db8eK3lrDBDFS7FhSX/qnhWPpHx3aCTYuG5iXa8Ix25Kj0g4feoIWV?=
 =?iso-8859-1?Q?WtOIo7VArePuW+XPJAcvm4ETy8PLDy4KU7CyyGOZuryq+3PjwR7JpKoHqS?=
 =?iso-8859-1?Q?Ckf9fUPNugV982dXDRYiwTg2WrKlqH06usNQxqMutHJaLykyvdM0B9qkRm?=
 =?iso-8859-1?Q?FIrScLqFG+5qv4Uz5CUC8H3fWy7/oIkVjPQLHfNkJpEqVEt9iuIr+GRf1T?=
 =?iso-8859-1?Q?IeEPhqn8iipatIuFlMBLKQekcKUjcfMGbHuFAIEY61+HKmI0m2YVOu6aYz?=
 =?iso-8859-1?Q?ZFD5R8ysUaM9uPk9p5/T7uzg5G6qdZuerQfeHl5//+bogrwxBz/eRwjCfZ?=
 =?iso-8859-1?Q?iozlrL7T7QXXDmC5rhSTvD7KQg7UZfOtdvwXTZ4YOOTQ2l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609ae73f-8752-41d8-0769-08df13a3f282
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF37951B1C9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 03:38:18.0886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQZjmRrFtXC8kI/lnDbyV+fqE89VBh84TWzJji/dJfVsj4d80LTikfNl/VqZ+xY3xN1W25R3hHLz6y5pmisTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
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

On Tue, Sep 15, 2026 at 05:48:04PM +0200, Christian KKKnig wrote:
> The blunt reality is that I don't have time to look into patches or bugs
> any more as it would be necessary. The same counts for Ray.
> 
> Natalie has been working on the dmem cgroup patches for TTM and agreed
> to take over looking more into TTM.
> 
> Arun is working in my team and already maintaining AMDs VRAM backend for
> TTM and the underlying buddy allocator.
> 
> Add Thomas as reviewer as well, better to have more eyes on that
> component.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Yes, thank you, Christian, for your many years of valuable contributions to TTM.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b5a4e4b35cf..b6e58a138501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
>  F:	include/drm/drm_privacy_screen*
>  
>  DRM TTM SUBSYSTEM
> -M:	Christian Koenig <christian.koenig@amd.com>
> -M:	Huang Rui <ray.huang@amd.com>
> +M:	Natalie Vock <nat@pixelcluster.dev>
> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
>  R:	Matthew Auld <matthew.auld@intel.com>
>  R:	Matthew Brost <matthew.brost@intel.com>
> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> -- 
> 2.43.0
> 
