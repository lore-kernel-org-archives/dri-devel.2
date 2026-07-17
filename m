Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDCEC44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544DE10E47E;
	Fri, 17 Jul 2026 13:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CsJzJc24";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F127710E47E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czLqNWIYKfL8i7IX2yNGM2hx8fXgAs50eLvh/btoxzIHd6+FGUQCHE8EPDze8t6y+qmqIgyN4qM0Q2EP5MgayrJtrHSU5spRD6GlxrO/O3CXhvY0760ISbZZ/tVjTQOTUcj0gJnMUUKdzCxQ5o+3Twu0c735s9Bm1SLshy1vGBu/iWQ/nEbme5jsdyWofqU2uhe33K69/BCZ4PbPi4KtFSLe9+jLLSJgQSxzDByRxcUgBigHh+CQHqUat2xDk8whg7380OftbLwGpQGjqmEBMjKquop9RttPL7V9CFKo4l4eFPMx+3Dkc9Fe9lV4+HUVmKE/sgkez9+Xx7/QEhV5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNOzlSdvzrzay8tJPIJ4H9pzgadD7/wteqKQYpsPefQ=;
 b=Kpvvxrbn49aK1I6JR3YlFuhDpxHYScQGGovwIJPLIHXaROwYJDSnUu7EU8XE8wG5SdTOo9PZ69kfSzuGs9UKP6xKOI/svaRoTE4n19JiPgZ8rUWbuEckBIYaAS1sNtSguGuoP4kY+/yssv8ntjsH07s9NApaEdHIgNzRUg7wc0PxQaFGvXWtaXSVsOKyAFcGeozE4BvmlvadlXtuAQhUeyzUlOKvyGxGFlXb5IkxYeCyhp1cvjcDVAQGEkTkfvUvp6OJZM2XRknE/GJSUAF77/Xm8m63vo0/4WLyUdQCtrBWMM7msEgaUA/Qy4THngdihmHibqyuttsgBxlnxY84AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNOzlSdvzrzay8tJPIJ4H9pzgadD7/wteqKQYpsPefQ=;
 b=CsJzJc24+CMpflaHYHue3a6g6q/hWO/94icMTe3+jHx8r98EIJaZuWzMmgpCL5QryGg3ysG7tu8SZV7BzTjNKjyndkqtWdakATXcinz42QQ1rrvyWRxm5O/civbLHxjCxsvsHHWmXBFnMhaaAwQq1Zo0TUHIB1aOqO/hMJDL/k8T11eyebVG+uHA+pWwdfPVuQImgH1JPF9sBXoyZKPfn5f3Fh/UTP9NUMhbQZFcHA1o9S6gUW0x0Hmz1i+wyXTlGe55Ojunbj3CPZBJo7asljfhBx9jfEQTh/sFD4+YwaPQWb6aqPseJMO1m6WrnOG3AO/9oW/UB1KIZ6u99VLFvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 13:32:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Fri, 17 Jul 2026
 13:32:02 +0000
Date: Fri, 17 Jul 2026 10:32:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 maz@kernel.org, oupton@kernel.org, hch@infradead.org
Subject: Re: [RFC PATCH v1 0/8] Arm Core Local Accelerator Driver
Message-ID: <20260717133200.GB699082@nvidia.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <aloS_T3LQvpHeZUV@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aloS_T3LQvpHeZUV@willie-the-truck>
X-ClientProxiedBy: YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5276b52a-436a-4987-daf3-08dee407c8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: LDl6AP6yPTab0ydMtxSZkZVRYkIzwIBRVw9kAucVzySOhaytP8PFtMq6VJ5F3r2Ds6spdLvktfdb216hJeIWk8DB0dKSn1sAaplbO5c+k2XF6tooSFtSAGVqekoJ0L86jbqsyeipdc8JmRguAc8bZyAyqBwoTdFQ7coeo1gcss8wXoB4pkcqcnPJMtrNyuArmZRIxOm2Mo3KK0dhkKPhwyp1nuEsBy4JYEb+NGLPaUcSFF1PsbBUaKo1tQe79GcpgVnjAjkm2fF2RqXdtJA55taczdiDCTzQBNaGuH0fKosEnIi4rSOojzBQGCQfrP3k9QNPS7T1pxml83MmSl5J4tNNVEzEad6VfKlpRH6Cf1R8gx9p6XkDI7qSVnKrCNUrr/fnMh/f2UbGAzekXP1LCqInhoD2idlRcN1Iobpg4dmhMnVk/PkD09fZ1pycsjRpqwEwYsi/72UPcXc7655kFMM8/SFluNLA3C31fcqqTTN74iHYYrzw3K2Swv/xhDiXRj3ZVGCMfK+eoCtyrEl+lCEl/Y0slLUPbzrN6pUV/QycT517qfsyBfjPRRL4FHekSwX9bZvVPUKAVyS6+UiocTna4gZqxX9IxE/IlXNaJ6l6L+EyUav6YrWaBoIPGhMTNW1MU+bD6tpbhqNh4Hv1hecy9/EU9Ggh8W4d9znvi7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6PEeKIvsQOe1Otx7lp1M0Q3W9jUqzFknYTBVH3gAFfP6Yzm2vRYgYqqTF6Z?=
 =?us-ascii?Q?SPhF7bKa77h12zIHc8nY186ztNFcEOJOQHuQJ/zeO4Vowsj0euza8a8p5eAe?=
 =?us-ascii?Q?cBNtkupudLHeDawSvcuJXwjDsqrtytvb72OFSnVZFuXXN8jO8IvC8TK0tPTi?=
 =?us-ascii?Q?LEFADhGUG+eh7+Fz0VYhCOqGZfRIdTDWDb+LRWOFQKVN9BGiOz9AnSUULgCX?=
 =?us-ascii?Q?v/r/r44rGd61Zh8saPzIqAdB9m3omZb91xKteXIBreQNnezcJdP731Cn240r?=
 =?us-ascii?Q?xn8jh1XanaKZmb9YWizZxeAYr6SxvQP9IaomKnD3MyaiimkQDCem1ozyDOt0?=
 =?us-ascii?Q?+Tj5ky5ovkHGmAyUumOlDyg1lhgGPQ8dGSHE1Uw+E9MjpHUQy/JS3AyjKXoi?=
 =?us-ascii?Q?+RbaVhne+aO22tJHTJT5+JSR3gawtBJtOcJLrYf14CLyzD8Z/cZ7fqsi/AGN?=
 =?us-ascii?Q?155BcO+LJktSJw3nK7yR3Ywlk505eS/e1icNoANK0jJDzQs9BY4P+ECn5fNo?=
 =?us-ascii?Q?5GN9YAip485aShfd0roMOtRYLSj59fpLZ35rCzhoMVUUo7Bvgp77sIQomxQq?=
 =?us-ascii?Q?G6071dpQqtdiYvA3J/XpwHgrnjBEwbLhCamquRGGc4618aevsZr6goXey/gG?=
 =?us-ascii?Q?32rNfKWxnqXDiFvIMuqw+8Fd7YH9Pxb4Se8330nsq6D/peo4eyLhjgHLM2oA?=
 =?us-ascii?Q?dXE3W426BiNTK9r/jeqs4+We4XcK0nZHbU+EibD1SBEqtJqBXn9PYB2BKTJ+?=
 =?us-ascii?Q?jmnaT8LZTwRLeA9JsegEMU/0058PyY2xKibUwk7hsTuXftAdw+Fnp1QbN2i6?=
 =?us-ascii?Q?TkL1JnOjju2vzCentOFAI7AiY96JIrlwgaNLBW3Nx6VCzoUn/Lm2MFvFHVpV?=
 =?us-ascii?Q?xb+OjKJ7hWhHmKGzzuFDJhxyJ1hz3w5s8fFrC+79jxwFsFVpt7ip2R9Wqlh7?=
 =?us-ascii?Q?Kzs+PI9aidsvdEVxm+Xc2m9lUftTHe4frPFYydFiyLAIHpxwhAL2I7GR+qiA?=
 =?us-ascii?Q?9fzcVf2uFtqoOHn5RfzM2vHnHdsIYcIInedgYzhE3hyNgdU13tODrMcqQ+5p?=
 =?us-ascii?Q?DtQIyQEhhLX0fDSpgTk1TSiWR74S8jVcUr6gwz5gNnvOqCH9g2a3+vYrSOS6?=
 =?us-ascii?Q?wMXyWenK9gK7ZySxqhsHlkeNOgFEDsTrrAvEyNoLp+aCyegFa+ennXBP2E64?=
 =?us-ascii?Q?XTV20nuXG+dzLH6mrxCHHwZvO36gjqr/2DBPEG4Hi6WpDKmV/qZvSTjrrb6V?=
 =?us-ascii?Q?9jFzFPcLo1GwWMUuW4H4jeXj8JD5fY2UyGOJGxMqj34saT2YqDPspoaQKx4C?=
 =?us-ascii?Q?k++XeoEe7C/Qau4p2NuGv4jc+7duhl2VUd7dSdQrl2AboQ7kDrPAeXcHYcNC?=
 =?us-ascii?Q?tXPVy/YmtsivQFqQAi7b4QvAz8tETcspx519cKoxomIxrh5BUhO2rtZgiv3b?=
 =?us-ascii?Q?0bX59x55xSCfCUxcM65DYf+JatINDOvAfh/oAFvgs0xNxD9lRBgoEtwr/D66?=
 =?us-ascii?Q?cyyfIvT9rPmuu7/rvu+JQaHjsTU0rsnX1hIPyE4JONIlhKAyY/5TSAOWGzNx?=
 =?us-ascii?Q?3zeAToptqcui6GKf/Vuj0WIOHgpG6u1G9TJQpCUswFkaN6CztJvVUQSq0frh?=
 =?us-ascii?Q?giilZAGYhJmPauJFM7+iHxxv4wGg2xk7Q0kd6A72c2xvOaikeUlIJo95KQ1o?=
 =?us-ascii?Q?7D6muF5IGDxe/hDfnFHaAZpFe5yDzQEzPdgQyZtb0PJ/jn/c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5276b52a-436a-4987-daf3-08dee407c8f3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:32:02.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30oYjSc9RGZRsG/e4+8hZnKG6GAmYD4S/J+/96AGOr2zZHu/3h6tQl0wRzHt2TLs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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

On Fri, Jul 17, 2026 at 12:33:17PM +0100, Will Deacon wrote:

> first. So, at the moment, this just looks like a burden to me, especially
> as it appears to create a brand new, device-specific UAPI for what is
> ostensibly a form of SVA - something which the community is actively
> working on already.

Yeah, I think it was a mistake to hardwire the invalidation to the
CPU. It would fit much better into Linux if the invalidation was
separate and independently controllable with an option to follow the
CPU.

Then you could use a normal S2 page table through iommufd and not mess
with kvm. (though the VMID sharing with KVM for a BTM-like scheme was
never solved upstream)

I also wouldn't expect you to use vfio-mdev, if the devices are
discovered and known at boot then it should be a normal vfio driver.

Jason
