Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17234606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 04:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y79qNJlB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7875D10E1AF;
	Mon, 23 Nov 2026 04:27:12 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD8710E1AF;
 Mon, 23 Nov 2026 04:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8B0mTK4g5mWlbvRiilZ5DI7mchKEwDwSK3WRfTVEpRUFZ4H/T0mbn7vjK0tAZp07toMFM+oCdd7sOj600UQxr6V4MnQlSn5rwaA3iTfYitGr3YBOWOsH3cP4TNFWRhbqaxfnKHoOPfdRaSxzEZtiHLBVgkkNV94sVGkzDPVzJGlPElBa7k5P39T6Nl/lWSCuhD8szlAn4F59RfUaru1l8xY9heGpB/SNkatWQFaBYjlGsVG21K+yScOTaO20iLISYjPjtaTNlq2NdQCoWcSlFsd4vhD2HSYfJChjsAg8GzVr2QZsDQSdlYToq42IsKwF3WVtkLVui4EXP07jroGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8shtKh2CJeynvZijkpOm7SxmCfLX+b7ZHs3NPJGOD64=;
 b=hE/40mX8MmOLDBDK4ujqNbZt8aIUZDn4f0f7/XbByKP0g4gW4wIkrMKVIFxjv+/Bwes14/leKGvRyjlxbfKLm9iLPZpUIe8T8T4jVX5gD3edNGCjacBkbHaly4BSS6npqo6KB+bDRefJRFuxymJr8M247zVu2Rcgh5CZGXwMoKCgRHoX9Vait+RgvOVImLpYiK/aqWaZcO9/4glD9orgqYaUpo4rWYsQbDTFSshoF/WsT/Ib1zD11TrnS7OlhtIWz3YTtllH4HN4IRtcpIJ6oirsE+7ze497YaSt3T3ax/zAt5zjKZ/LmRxtefo9OMJyPNgiwYsPHMdnf/gGPswL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8shtKh2CJeynvZijkpOm7SxmCfLX+b7ZHs3NPJGOD64=;
 b=Y79qNJlBxJZ5hm1xtTD9GMeIH8hkOG5xuGw5+Rt2EuKQXNRkH1OT6B92zwE/CLnvo2RxL7i5Iki2LdMPENN/TBK6qwIZNrrKNYYLdDs4b4UzDf9ta331ACKtTJG2un4BfFtSGqfbI1efMpo3wmO4NZpNP8u1WoB966ajJreOn2Vt15utdIsWzAb+zzdPsvhlunc49eJItAsWBqzvTajmgx5WyTzelq9LyuTik/dTZltzk35GEjLWJxoOBEpPIt4mISrCF6rJqtzGr7LNnloXyQfTUaLyiyjlA4F/v7eew/cgYdmJL9LtV8Mt7wSdd300JCDRG10eKpYjVcYYPitZwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by LV8PR12MB9665.namprd12.prod.outlook.com
 (2603:10b6:408:297::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 04:27:03 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 04:27:03 +0000
Date: Mon, 23 Nov 2026 15:26:57 +1100
From: Alistair Popple <apopple@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, media-ci@linuxtv.org
Subject: Re: [PATCH v3 24/24] dma-buf: Add kunit tests for mapping type
 selection
Message-ID: <awO8FGMeDLMfDgv9@nvdebian.thelocal>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-24-c0183a409bdf@nvidia.com>
 <sashiko-outbox-226692@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-226692@kernel.org>
X-ClientProxiedBy: SYYP282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::11) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e2ce4f-f08b-4f4f-cc09-08df491a0628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|18002099003|22082099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: bguJ5aGcy/+L5mC6h4DVt5sY7GBj022e52iRW3YUNdJOtUAmuJNEemWzvpZa9yIVBdiIdDZ3+X2rMBCWHN662VynTBMUPDehLtptKKKPg6ohMwRGm2E4SZLh+OcKv6z/o/rvDT2e6rbccQ+/dVBqaIshi+0VPVwh8pGnvHhya4xNpRf49lqM0pgfXXUolPZvIInR/9orRyslOd+eFHEYZlg0oMS9a3QyMQmyHMJQnu1Ma3rrH6zTDLKWMDsMRbrgrdAPLR66KXz+YLBQCW3ZprZ04ORI1xMRf7Q8qOBXejYRjZm4nqLbdpuh8MkJCDnTPZ/E5Rucm0swReYIYdjpEgKsl66jfJn2igqSrdCJ7L+SIWofrrIl2+AjHDjPnUOsmiOhjttZsg2GF+SXbSdFEYdcpVtUn8NNDSKuG/c5vH1aHS+wMOp9KK+kAkLkWXf98swlcKH0AT/hWmQ+D16IZDocKSb3vaZtuhWGYmI8t16UUG/+Pywvuf7xInR3CZJ4p+oUng56BSgsVgHukrC0SjU7i5kyYQhUkCv4NIOarKWVLwp6Gh5cTLs/PNlsMHOE5KWgsu+2ixiykq9WQxQ4L8r9rAUdwyRgb3FaGB6x/4qba6dpMYDARCgqRP6kDFgYx843vTcs5r77Bxf8Ghai6sI5WBVg7O1UQ0vIUDiGh6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zSOljHM3F0jmHLYn8osrojFxQ7TWnHxuxdjnM2GxsvAagtSvyrr4W4qJKt?=
 =?iso-8859-1?Q?3q5M09szxRs4fFT52r7DRf+luspZem9nZVwm6PQpaVdvKLt8ykCxsB7xZf?=
 =?iso-8859-1?Q?8DWWA+GEuMH47KOeu9zNZ/URjAdiYNb3Yg6PCxMx8w4gD3+JxAHNeAqwiX?=
 =?iso-8859-1?Q?ttHBJN2xsvAOl/BovQ5P4TkyOXGjXkGNzLClS/1disAzTzVvr5mPTkPzSL?=
 =?iso-8859-1?Q?DYrygLx4/O0ZZG4xt2x+d7Bg4yiwQfFslJuEgZFgQ653rUJWZjwEHChJPW?=
 =?iso-8859-1?Q?fRx4UxLXfDzRKab83AWObNfRu1ihAFKxvrI2oVpwRa9YEHc7TFpkijV8I5?=
 =?iso-8859-1?Q?h6zehne3gHZv+6xJBGOkXikud6G1blUcfUSVPx2/9w7VIdGYIHZiYx+PBW?=
 =?iso-8859-1?Q?H67FZ391xKphuGclsS0eThh0GWHgRue9AgYK7JRjxfk97y2Yv+dCHg2QwE?=
 =?iso-8859-1?Q?AQgfCUx0Z3C2NMO1zdU77a/bFafhFaqd8OUyhh83cbcdLBM5iiVfDJBOYl?=
 =?iso-8859-1?Q?sJ/HnnJefzBL52w1HIXo+od3aCNL9FQtCp0v5pgsDnpJI11Mrf6AX1HojK?=
 =?iso-8859-1?Q?GIzCh1XvFHhCXiwQrzs40W/88rOYwp8PJ2XML7KVUDIpXsjc7Op4e83TFl?=
 =?iso-8859-1?Q?P5XtFRmSX4wSr28YScfLzaMD8glBm3owtvzMNBb3tRBZQdwJzjB1MtR+cV?=
 =?iso-8859-1?Q?Y/e2f+tPhQb+DaXD+ZJ8TkeE6XGSg5Bm9zQEyuN12EL+AD6fDa5sooHwkH?=
 =?iso-8859-1?Q?alfth2XiBkbaMqDE7shoz2wOOf711uvQd93LMS7JJpUGAf9twGY6UPAQNs?=
 =?iso-8859-1?Q?I0mVX6f4h03yOea5i6FpqkLnobRNVNJ9pbYKaT/seOKiplOFqRNkOb/Zhq?=
 =?iso-8859-1?Q?I26ehwFRIQgeIj27pBA7qHL/SMAvaZt14Zz3fKFPyCVpOdoZb8kIzuc60B?=
 =?iso-8859-1?Q?rEnbLRofuQxfTJR2Paa7Z7Nch/yL+Ahu7oshxJWtvqqCuXUT+8HnlZMSJZ?=
 =?iso-8859-1?Q?NsAPvhPj0ycYdAsPuX7auD9oAVTDS59T/kA4gcMoPCnKpBdrOe/NzsvuiE?=
 =?iso-8859-1?Q?n+vqI7thZYOL0qE9pcn+UkA5Uz/4SPicZzD7y4J92wXM44DE5EuU5Xoa2B?=
 =?iso-8859-1?Q?8zvvdYGuocxcrY1Zfchpka83Bhzod1YjgfkvVxxpx9/Ky66Gd+LObllJFW?=
 =?iso-8859-1?Q?0f/U+LW8vc+Ai/7rTtoxEw52wsiEUO9/14yRgsfY9nsNBMdkmJ0N0TSuxK?=
 =?iso-8859-1?Q?QeonEA0T/QNzfJHojDEefhDzN06I27/UdMHFqThL1HnOSf3Zdq1wjWomXC?=
 =?iso-8859-1?Q?ixFJvE8OE1WA0npS+k7xbV35GbenUcIhCLJbb4XGur/DVYVkYh4hAsmdoM?=
 =?iso-8859-1?Q?I63j2Qx2dU7CyAjr1m8DX/L04EyZbTkZBO9hJOWXy0ZWFjoO/PjlcVr+8S?=
 =?iso-8859-1?Q?jNmxAsJ75NfIW/KfGMsNoJ3zkltImtNTcGLpSZNzUG1SVX1+ZV6OnBD1s4?=
 =?iso-8859-1?Q?sw6Wk9bS+4tyqKLCLU0rwQ6Ake6FEFX9T9NSdCEpmTp0h7D3G8bf0IJFfD?=
 =?iso-8859-1?Q?IPElmIkWyrjKmwh6Qahhmxq91GpXbfs6l9pAQW3ER6kzr3xf9qFs/6ODqY?=
 =?iso-8859-1?Q?g3hYymzEcGkXD98Z/LDYixE1Kaa6kkkwuUhhy3jNMgd/+WXGQyMcZz8J1j?=
 =?iso-8859-1?Q?jFm/wEW0TbqSIBxfoKtPfCE3qxsHkChTZhc+hutOcOBv74LgCmXI3OVt5r?=
 =?iso-8859-1?Q?No9ErStPTcAN/toMujstq1zWKK7AUVHlQhVFhPrNC3Svse1337RWet0JTF?=
 =?iso-8859-1?Q?bI6v6kLtjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e2ce4f-f08b-4f4f-cc09-08df491a0628
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 04:27:03.2392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcMZGHWpV3qhGSWIE+hzq1T29IBtyLQfjtTS/+ZGkxxLFNvMFo3RZsZcV9HfSDfiBbLCWo8hAa+s+J6JZ8JvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-21 at 16:58 +1100, sashiko-bot@kernel.org wrote...
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] dma-buf: build failure from mapping2->type access in selection
>   KUnit tests

[ ... ]

> > +	/* A second map does not reselect. */
> > +	mock_select_idx = 0;
> > +	mapping2 = dma_buf_mapping_map(attach, DMA_BIDIRECTIONAL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mapping2);
> > +	KUNIT_EXPECT_PTR_EQ(test, mapping2->type, &mock_type_b);
> 
> [Severity: High]
> Does accessing mapping2->type break the build when CONFIG_DMABUF_KUNIT_TEST
> is enabled?
> 
> struct dma_buf_mapping only has a match member, not type, so these two
> checks in test_unmap_uses_own_type() and
> test_select_survives_own_invalidate() should use
> dma_buf_mapping_type_of(mapping2).

Ugh. I made an accessor for the type in my final iteration before sending this
and clearly forgot to do a full module rebuild and retest. It's a trivial fix,
and I just re-tested to ensure the kunit tests pass.

I have also been writing and running some basic tests that exercise the new
dma-buf paths via vfio-pci and iommufd, nvme or nic rdma which are working. I
haven't posted these as part of the series as they are user-space tests that
require fairly specific HW setups. If anyone is interested I can put them
somewhere though.

---

index 42e6748f0ae6..6e88c36d8c9b 100644
--- a/drivers/dma-buf/st-dma-mapping.c
+++ b/drivers/dma-buf/st-dma-mapping.c
@@ -950,7 +950,7 @@ static void test_unmap_uses_own_type(struct kunit *test)
        mock_select_idx = 0;
        mapping2 = dma_buf_mapping_map(attach, DMA_BIDIRECTIONAL);
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mapping2);
-       KUNIT_EXPECT_PTR_EQ(test, mapping2->type, &mock_type_a);
+       KUNIT_EXPECT_PTR_EQ(test, dma_buf_mapping_type_of(mapping2), &mock_type_a);
        KUNIT_EXPECT_TRUE(test, attach->selected);
        KUNIT_EXPECT_EQ(test, mock_select_count, 2);
        KUNIT_EXPECT_PTR_EQ(test, dma_buf_attach_map_type(attach)->type,
@@ -1043,7 +1043,7 @@ static void test_select_survives_own_invalidate(struct kunit *test)
        mock_select_idx = 0;
        mapping2 = dma_buf_mapping_map(attach, DMA_BIDIRECTIONAL);
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mapping2);
-       KUNIT_EXPECT_PTR_EQ(test, mapping2->type, &mock_type_b);
+       KUNIT_EXPECT_PTR_EQ(test, dma_buf_mapping_type_of(mapping2), &mock_type_b);
        KUNIT_EXPECT_TRUE(test, attach->selected);
        KUNIT_EXPECT_EQ(test, mock_select_count, 1);


> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com?part=24
