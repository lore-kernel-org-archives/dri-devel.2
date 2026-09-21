Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AC4C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCBA10E170;
	Mon, 21 Sep 2026 12:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XEmGMjS9";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16A310E170
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVBscgSpYW3u4U6T4mkp50AxEoeKWFjIYvcl/SVWglf8IvhrN59A/1T7bXI+eHa6hahZHEcNFHZc5mpKJ53yrZQXcA0v1MeqYFo+Mh+mPDIUsVpI4GP37AEeF77Lx63eM0+CHj9QDRBxNyuCLtCDTtCsdQna6oSyzOeyvUEHoTuoVeP/YQJ6Z+AcUaXL4Jjj8D/K5yVsyekSPDNu+b1cJMHlbhCQfJTP5YTvwvGe6WZhhqb3bAIQbXOBy4AUjlXasfMUKnQj1zuTyozKveuh9KZ72RiUbNRRUBZMlNciImqdRmXDVl8LIaThatL7bwCIeFaUf3VMMs71aO8XaeD4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+/7I5N3draSpzaDsSxoFFBsbIo4qA8PGvVrfItFH9I=;
 b=SdOoiMz/lCCFzCyVmmSENMykSAS9AicXs+l1wLsHmFpxTPU8gf2eXBSqinre4X4IhPY6caLDgeRTb5X4SYPSinhdZ1GxLsrNPW7/MsICVdA25+G/FpIfBA1/J2BDs7Juw5alpKusK9IecktmzRXi4KApyTV9qdXM1qXbh/sAZZLq/DSvhQFqptEPruI9QpUfH517asu/Ou8VnF5JHM7DFVhsiLA5/RVEJewPZma57qLIsUailCD1Hhalg/bt3OsEwrRNrOUz5/7RVqgGiAvp1kCauW+AcgjIkTFTWEBvDxOPUe9OdjbH1wGXiCEBNsquFuoPcNd9uKLw24If6srM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+/7I5N3draSpzaDsSxoFFBsbIo4qA8PGvVrfItFH9I=;
 b=XEmGMjS9uA1+u1QkL0W+kcHkw1BASPJb8XE25vY9n3+d+rWB7vhPep65c3glJQ/reJ7Ss/6ucuSS91sq59CiviBw6yfLdxtdebvuv1muT8LUUEcJWLbawOZm3suVrSV94wo6NRF+cZ70bkyAZ3zRkqYjDupcVqY1tpdbaEazYLcOkbUK8KfGuEDpQJi9RhBKvCVPCSJaQhBov0M1N/2S3jcZ1kohFxZwaZ0aeHEFjHKiNyG5b1aTeXRa8UsKf2icsYT83Fh8g6wwoTl7Yvk0xyhH7jBu4B8zr+RKpydtM44KUDyOzuugvx4yjv7phUt6086LsS2Z8KFlJuzW6vkRdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB8157.namprd12.prod.outlook.com
 (2603:10b6:a03:4fa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 12:25:47 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:25:47 +0000
Date: Mon, 21 Sep 2026 09:25:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: kevin.tian@intel.com, nicolinc@nvidia.com, leonro@nvidia.com,
 leon@kernel.org, dri-devel@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h
Message-ID: <20260921122546.GA1487657@nvidia.com>
References: <20260921094452.679455-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921094452.679455-1-christian.koenig@amd.com>
X-ClientProxiedBy: MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::32) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5cf997-798c-4af5-5456-08df17db772e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uCpCLo+CGKsOlj5RlglBCJC8AzFM781VeGeG7RM+tQO23/dwW1jJTAHagoBrp0TBPLXHDEZQbs/pHF+OT74jSp2lqUxq5bV5uhhc8W6h3tHYgiakmvd14Ok7YHjh5OwDdVaScOAlVklvquRagX+vKqAltljPoGBh01uvF8Er0raSeSR6EwpMvDixGOskPzLCVPK/n9ntLRLa0J+bJcwr5HFaOmvb2EB/jiHjRai6d8DgoaFHkKAttOan8pSmcPW1aTZN+w7VfJuZHKKuFziuoiViB13cuYyMlSKLSyhhOp1CXhKSSLVp3s4/vq3jbBbH9AFREUJq7HKwKuJLAzZP/nSt28VyoLxEdkBatpe6pqu6zofsJWVuV+vW/cMp2kvS5WEpwys9MHrpVc4KScmkhuZXzvNExm3l9pzwoodBqcto9/+CdcWx6M99gjhvUWpvMI4gnDMMtTCrLN24XbdRM2iU0aAy4sr3z3aeAwaKRMtv9BMrhX6BHzYbXKwms1QmbyUMKQfIidBx7n3uQxvtXDeNqjSlt37J8NxZF2b/bTCRFUgf8zzTYeAZ5vvUiu/ZesaSZud6ZMv9e7oTjgxDcifx1uBQyZUdktJqTCCGGBSRzZJwypMNGlJ1wq2ci/5gCLTp9gzbPDXIctY6N06HcvP3tTKqrhHiKpz2K1j4F20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9WQWZHd3IveDYyK0ltYmxvZUxVVnhzb0RHekNVcUVFSUNybFFYMUZJbkVQ?=
 =?utf-8?B?YWpIUUVhUkZJd1VnYjRlWHNNTDZTaUUrRlZacTNtOEEydlN3cTlabE9UMGFG?=
 =?utf-8?B?SlNLY2l5Y2pyaUl4ZGJrRnZDdlg0SklJbkdVVVhLekZTTUNOQWVONzRCTjlS?=
 =?utf-8?B?UW1LWUE1WGVMSW1ZODJkL0dYbkZTTllGV2I5OUFpdjN6ZENmNWpqRHdpbHpj?=
 =?utf-8?B?a1pCS1lkbkpBRHpYVmN3UXg5ZXpIN01paS8zeDhna3pHQVhtVjM2aVgwMWlC?=
 =?utf-8?B?VGUweHkwMENWNi91ZlhYOHBuM2U1c1BrL0lnU2M0WUt6ZEVUVUczZ0hwUEFX?=
 =?utf-8?B?ems2N1lnRFZVWVpSOFBrQzZ0bC9nK21yYVlWQWpUVW45UGxkZDNuRS9HenJQ?=
 =?utf-8?B?M0lyS0dHU1QwME1pR3ZERTdTenpsZ1NzRFJPTy9YT0o4Q2lxR3Z0NEhaQlhI?=
 =?utf-8?B?UDVSdGczN1lhYW55YmhXSXBYYWRLZmIwQ3MrTWJpck1oTnM3T3FmS25wL1Vq?=
 =?utf-8?B?eWt4bmhjcGx4TkxRVU5FL09KUUVOTVVEbmNtbXdoS253UVdWc1VVT0JnbDhC?=
 =?utf-8?B?bVhRRm5WUmVSNUhUVDNONlBMaU93UkJYMmQ0U2FadzFQem52bUpJeDFQS1Nx?=
 =?utf-8?B?L052VUVPYkdCWmRWbWUwRVdvWFY1R2VjVENabHo4K05wK3A1dUVJQ0d5UGQy?=
 =?utf-8?B?TlpTc2QvM2NCTlBMYU9Ca2tuSHhwOVI2QU5qWDVWTitQczFXV25IME9sU1VP?=
 =?utf-8?B?SWJTdWZuN0tCOHJPZ2x0Mm9tWW9JUVAveGdEQXFjRndOaW15eFNObk5wK0pq?=
 =?utf-8?B?MThhUkpMTW0ydGZMVEdrVFN1QndjWDZxQm1rWDAxMzVpbVhRTGRseWg2MzlG?=
 =?utf-8?B?N2xPb2l0RElyQU44Qk1sYlBUbTVjSHFNdE5EQk81VzRnQTNSdS9FTGU2YUZJ?=
 =?utf-8?B?NXdNVHJoM0tuZHkzNitIQ2c0ODFjQkg3Y1RKZ2ltaCtkbXBFYjZDc05oc1ov?=
 =?utf-8?B?TG9YU20vVmN6dUYyTml2QjlicWt4bTBBNkF3dUxMYnlTSkpWTXhreDBqRlZt?=
 =?utf-8?B?andSN3dERG1DSXI5dmtwZ0x4dHY2cmxWNXNLNk02MVVBdDFoNkVoWkVRRlhW?=
 =?utf-8?B?VUhJNmpvZEhBWEdqT0ZnS3JKbCtGQjVrUmVDVkpOZjIweDdpREFnd1RxN2hj?=
 =?utf-8?B?VU5wbStwWFRZZGFPS0tQZ1g1WXhjdHlOOStNdDdiajdkcjROSWFNMVRsUkhY?=
 =?utf-8?B?VXpud1RDTXRuYmplczJUY0VCRTBaU2Nsb0xMM0VJblcyVkhlL2E3a3J2UFBE?=
 =?utf-8?B?d0piRm5reXRuc3ZqZkw0dXZXMkRFRzhwTHpuTDB1QTNLdElPZ0JYUWZyMWJD?=
 =?utf-8?B?MHZoMmJCT2JtanJzenhJT0EyTTBCVUZGeXIwMENVaEdzZ0g2bnliNnNuK3pH?=
 =?utf-8?B?NnBFMmlPWndKUGlxWklNc2ZMMHp4R1NPNVYrSVZIVWI1OEdJK0p6bmlCMnJh?=
 =?utf-8?B?UzVzT0pWRGdGSUJKMmhUQWRDTnlzampXdElITHZGaU5oNWY5VVRCeFdhQVFV?=
 =?utf-8?B?aWhtdThZQnBBVVV4bk1vcU9GZW9UdFEvK1ZtNUhlQitHRzIxT1JnZXA2M0lm?=
 =?utf-8?B?c0pJYmdZbE15bThYTEJqL01JSXAxSEZ3eVBuVVdpZGJYZlkvTlplWXAvN21K?=
 =?utf-8?B?SW96QW91anlLNlc1NDFYU1M5MVJxb1hKckJKTEswc2dockdGMnZwcHQ1QUVN?=
 =?utf-8?B?UGhBVDZiR3plbVpDUGtOR0l3TG5ab3JocFU3V2wxRUsya210aGZ0NnpGZmZD?=
 =?utf-8?B?Yk93ekZIMXo5VStQckRpMitpV2trQU9IZm5ZSlZueXlBZkE0U05zK0MxTXF2?=
 =?utf-8?B?Wi9NeVBCekxiOXM0R3c0U3V1RWV6ZGRWQ0ppU1M4OUJPV3B4SkJZY3ZyMG9t?=
 =?utf-8?B?RmpGTmViZTlVNzVZV0ppclhzNkRYQmllZjhrUCtxSjFkL3NWNG1MV1RNdHNF?=
 =?utf-8?B?M284UWxzUDZrdGVTa0NqOUZBM1dTc08weFY5WlYzYytWaUhqcythbGVUSTdy?=
 =?utf-8?B?cUd4ak5GeVkzT0U4cURjMHRrRG03VzdyNWNOdlRhc0hJUnYrNXd1Y0NQODBY?=
 =?utf-8?B?b3VHN01rT3dPT0xya01YanZSWkIrMDg3WFJuQW1HdmhuS05KZHhUSnV2NFFy?=
 =?utf-8?B?cHdwNHQxbFVwSWlXVzFJMWNRWGtBdjcxTDlxeXc5NVZaQjdnM0xQNHBQeitP?=
 =?utf-8?B?RUdNK2VxMW1pVkY2Qm8zUElLSzJHTEJUZktGeCtyTWUwdXljS05rdWxPUDZX?=
 =?utf-8?Q?b2JWa7DRJRXLQAIrSK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5cf997-798c-4af5-5456-08df17db772e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:25:47.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUHCrbyqjJ0mZYY8L5HpNIkFDocu/6MRvp7uyU7H2KCLY+yUUoHgIHyQJWscrKi+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
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

On Mon, Sep 21, 2026 at 11:44:52AM +0200, Christian König wrote:
> That is unecessary here and creates an unwanted dependency to the PCI
> subsystem. Move that into dma-buf-mapping.h instead.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/dma-buf-mapping.h | 1 +
>  include/linux/dma-buf.h         | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)

> diff --git a/include/linux/dma-buf-mapping.h b/include/linux/dma-buf-mapping.h
> index 09bde3f748e4..fb5e52260700 100644
> --- a/include/linux/dma-buf-mapping.h
> +++ b/include/linux/dma-buf-mapping.h
> @@ -6,6 +6,7 @@
>  #ifndef __DMA_BUF_MAPPING_H__
>  #define __DMA_BUF_MAPPING_H__
>  #include <linux/dma-buf.h>
> +#include <linux/pci-p2pdma.h>
>  
>  struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>  					 struct p2pdma_provider *provider,

Let's just use a forward declaration instead of the whole header:

struct p2pdma_provider;

Jason
