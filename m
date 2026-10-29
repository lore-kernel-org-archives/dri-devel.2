Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=a4wdTxSJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86F4112453;
	Thu, 29 Oct 2026 16:21:04 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011059.outbound.protection.outlook.com
 [40.107.130.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B8F112428
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhdgjnKDQO8vqaC6J0HR4bkmgn0360/IkktBLccrmb/1L+qn9beSWHc1Ww8X1DX6fwjWdCTG/Jn7Rnyh9exa0+6EWLoaICidm0+n13zuoFHOCcdpaT0n7egsv2cq+N43NHket/5UdfM7DKLPG9rMuo1rMIhgQslZqN3PqTXV2JO4C8eJEeVtlWhK3y5ZNd3nKGHxZdPf8HY9L6xU0dvPy/STydrV//RJfIPVaMUJaLmSbDinqKeex0aPrUFa9l0raGpx4pGeJN0kfbpJgapP+3XAR1PNt6E/Z7Bbrho/CHinGCwe2Y7j7lM2Q8ItOX/VCkzVJs84AFi7mJZacL4JJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pbSWmbmq9yuURK2Z3xuj+VpTbBl2FUfkC5rskEW1ow=;
 b=QxB78WgkCyvnlEBvcpKy8MoqzGFA4cc1fP8t+S1RcC3lurztru1VsvJ41wI9hQGlNL5nzdt5BNn2R6mAdEdO8mKDFRRnZEOS5JfCWQ28JEx2UbWa3lpkiTKq5VmtO6LRgSkXjFIHZvW9d/J0c+gpPlWmDFxi1ENJ02x84+KJ768fhV85mdR1Aedq/2Dk5Hua3qA+gwsFmFYW0wSlOatP8rMU3MXymjKCcFImS+Sef//FC10K4cCM7XeWQiI6R58ivde14zRwosBIQNTyyKwCVlaVuQL8etbfe2KV28aho4Yikvz+xsJxX7pnhZHCGputbwlkh0vy6atsK6/Y3Rfcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pbSWmbmq9yuURK2Z3xuj+VpTbBl2FUfkC5rskEW1ow=;
 b=a4wdTxSJ9WjJ0j5IAxoxqogN7D6fL22sSGTXoZAv/0pSJALwugn+epPZbRRLmBbRUj29gnpxmmYbUVmaaszlpwgtgXw5Vdbj++1UxmCbcU9PR2Sh9H7rKcMSYWmxoBg1psnTylrBhSefbXyVdJ+yTc8qDiWbd2DUaQc44263zQtZh8pIAIf+jIhEQZe5g61cj80ftj18MseKNo9Ve0YWSeDWBAd8y56ltYDq7RDz2Xs8V5C9aiRdmqm14d/Msit7YDfdlV3z3ba1TWTPnA/KHbCz4Qm3b1EsXrXSpU0vQnXb0D97J7UN59s3Dm8wv52TZrhb85EhmoqqJHhCBD91oQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8439.eurprd04.prod.outlook.com (2603:10a6:20b:412::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:20:55 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:20:51 +0000
Date: Thu, 29 Oct 2026 11:20:42 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/31] accel: ethosu: Fix probe error cleanup
Message-ID: <auNyWqEBu3F0mHlz@SMW015318>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-3-4aa25e22578e@kernel.org>
 <auNrrlOyKRzSp6vv@lizhi-Precision-Tower-5810>
 <20261029160058.GA1232511-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029160058.GA1232511-robh@kernel.org>
X-ClientProxiedBy: PH5P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 297832bd-9c9d-4d3c-904b-08df35d89992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|261009223027099003|261028144727099003|261026121527099003|261021123027099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OMow5K/owid7DvmoUjonsLQD2zVGPjYejZnmq8JZlcjQfos0semk4dHhr9t5KjF9CbNsd8BtuDTJvboueaeFoAZnO0bK0fqTVbQDwUX0d77TBD2Zd87hj3/Qb0hFE/Phcw0/ZKk0EedShFXKxVjZgCdW3LCBr4jpWHDnn2cXrZY/qGbIUyAGs/lUgbuZUtA78YuUB4yaVsOZDehVvGGtUK/a42iuWW7ZxNlDE6yDN/cOHA6BlLCdK3Y184DyLMKiNx+ci5gf5bbOSXkvRE2BGck9V1g/Er0Kl7k81YkySC0ACJ+HsjlGqIFVmve4zbIBi63xgYSS8WMzm02nqWyVWb5jf3b+4z5YhdBBTvt1pDE0usWXsO7jTDWrlao2QbT9MLyBVVOsy2rUJXxcst4kG57yYP/leZhHGvAbbzURA1CzYjP5K8uKCOSvID8t4yYBYQ7qzytu4p4qSmSB5Vx6Q/cWL4dekWTAr7HoJ8+wrW+14QS3cibOdUu4zDBV20MXG6/o7qNGLYtRIroCBl+3SXGXh4Kj3j01t+Ql5HSM04OkZJU3SWhsL41lh/Lg1yBBYLcgAuN85gPFpzUHoDlbOfsP0U/dSKHB3i9Cs5l0j26xOnaYgsS1j38OVAUEhCW+FMqwfHbsqVPGHyDxcSBjZ2rAWWY3neLRtXPdz+flpIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(261009223027099003)(261028144727099003)(261026121527099003)(261021123027099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mh8Ew6RGuuOAio2Jy9YZWjs57iWoIGDEcmBYEG6r6ER1rGO20h0RN3zzZ3DN?=
 =?us-ascii?Q?d9e9btSb01LEEW44qPsHNQ/WH0DlQMhsvooY9DC2ENdy1enQRZ0ATIIYiyZM?=
 =?us-ascii?Q?uFvlmU8UyugY4OKtSw8w6giglbQ1hAPFGkKOEZmYYhwhQhyBj3P8rzX52zKl?=
 =?us-ascii?Q?xg+SAmNgT7GFP/7wsTCx0gpB0/cDuXF7rR1BZ9E0jLheInwJ9p1/hbdxmVtY?=
 =?us-ascii?Q?+ZWvWsmYRnwvY5x8bjZ64tUKOq4eISiNtMtNpoxgqRYfh4TfZ/tAn2utE1zU?=
 =?us-ascii?Q?Bl6f3XFmjqhbM1ZJUoDcsqxbVwv58N1u39/2fmvMLiVRiYU5WMSDxHyW+Vx6?=
 =?us-ascii?Q?7lXsfCCiCxwQnFh0czRwOJIHpzBpmB2kNxcoXmF5yZANxltZELe13NzUT9+8?=
 =?us-ascii?Q?DNyauXTaAng2W2SfU9UW6PC/lyUWreRc/6qc9O2Sey+s7xNdkxXQOcua+N0A?=
 =?us-ascii?Q?UlvNw6szXN5ryKUX9FJkXO+pUueU3bGLMdYRN4V5xlmc8vezg8VtZnW4Sgwx?=
 =?us-ascii?Q?zvuEFv6p7NnntqD9/ReOnpbH6AzeEjIsrRTrNx455U67AZa3DU6bzO1fVGG9?=
 =?us-ascii?Q?RqoLnhslEGGsF0hVaZbJJ6qPB3oMU142kJQI+VvLB/h8pIeL1WcOub98isdq?=
 =?us-ascii?Q?JAkVj/ytyEx1OJmqJG+e562nQZdUXhEhfU1tKQ4yVYOd4DVHN7G3ViwN47yK?=
 =?us-ascii?Q?ffdJ2ZxeuO3hvfLmWKeNCoUbDWDBKcFHxzpj+1aDPP2hCJTAGjQFyKdQSFGG?=
 =?us-ascii?Q?exAyZR6MzYmVTxB0mdwp9vws3zvVA6I5L3DkYs1QdPdfzyxuoDhUrOgZ5Ici?=
 =?us-ascii?Q?3JTZdljgBKOQQkLFSaX0JEwLLOZ78jVeb9VBqQGLGuERRzErwKsNG1lIivBv?=
 =?us-ascii?Q?h3MYJ7hd/tV6Q6RC8Sb6f2PF81nDCdmslruLpuofFbRhatGBMgoqdn233Hu1?=
 =?us-ascii?Q?+nuezftjU/nPhnWHwHRQm9L/zqzBE5euPxPj++OFDqsU0NeKly+duRDBE2NG?=
 =?us-ascii?Q?iLgyCqnHEWZrtO0pHgP/3K4onPZdr641buJqmC0JRZXLGiEWVaQncHH9qTpr?=
 =?us-ascii?Q?sDauloInxxLQt6TLDB65+I6VqVdKl0E8+VO4fpcLBNayCH60DOcFdWcljj5b?=
 =?us-ascii?Q?xuVKJrlBdT8iMPH8Hyc+ioM1IOxbWQ3Y6xHxhJFtP2uAyiOjgFKqkCy1+HOd?=
 =?us-ascii?Q?ZMxDq8/YOL2OHVzH1sNBDabyZS735Xgosj+EWIpPUpfsSrATULZBhRlbjDYO?=
 =?us-ascii?Q?P7/eM2gUycaprx5DDMWab/NHwOlMG8f345z5pQJ8Af0npKSF3MN4rlTKgxDA?=
 =?us-ascii?Q?NIUfle5UQ8Lb8F2SWdQk+kUgVC4lEIv7AsQr+Vujar3noB+SLl9l2DyUy84T?=
 =?us-ascii?Q?KsY0cTKVLMTb0f+tnRKdFfMVwdhwmZo0wvR7juHZbgQUAg0SVexUaSGQ1QMA?=
 =?us-ascii?Q?nTBS7ilPQ97R4RmKdtItO07ef7Gp3mQLAeXRY5ZtLBkWH8D38tIeoeeCFVdQ?=
 =?us-ascii?Q?/yH7WuD8ZFI/pP59XQTjp4pWQwQV/eJhp+uXzocoxT1Vg/YQry0XZfEm/G9+?=
 =?us-ascii?Q?gb0L1HVmO7CmNw/cXDzabsCzltizqund2OL4WU/+R33LJB57pYwAy48J24fr?=
 =?us-ascii?Q?UEb79rPtAQ4DPb9XlbxgMbf9D6H6baYLYfsXT7WjpetCHBKmwGv+pFjFZ1HI?=
 =?us-ascii?Q?Nb9pyyzsdUThvVRLhlaLuLqDdfEzXJjBO4Na+b13ClsREit1ypnssJEh2cQF?=
 =?us-ascii?Q?10Iu4Ip/YQPuErRRZoKPvdHhPOJc3LWphkl9eVSOckhBSeVqqxTu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297832bd-9c9d-4d3c-904b-08df35d89992
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:20:51.8171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMMoMlX8n1rPmYlqnHStIaijcZOdSjmHPQQN2w0mNRFTfOM7P/BORhXof8rCmT7hY1jgVS5xUyVGI2N7CxiQVFrIMIb/1baGXydh5JKkaQYYv/+tOsKgGifY88dstK5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8439
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:00:58AM -0500, Rob Herring wrote:
> On Thu, Oct 29, 2026 at 11:52:14AM -0400, Frank Li wrote:
> > On Thu, Oct 29, 2026 at 08:35:50AM -0500, Rob Herring (Arm) wrote:
> > > Once the job scheduler has been initialized, failures from ethosu_init()
> > > or drm_dev_register() return from probe without tearing it down. The
> > > registration failure also leaves the SRAM-pool allocation in use, because
> > > the platform remove callback is not called after a failed probe.
> > >
> > > Unwind the initialized resources on both paths. Also do not call
> > > drm_sched_fini() after a failed drm_sched_init(): the scheduler initializer
> > > already unwinds its partial setup, while drm_sched_fini() requires a
> > > successfully initialized scheduler.
> > >
> > > Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > > v2:
> > >  - Adjust for previous patch reworking runtime-PM suspend
> > > ---
> > >  drivers/accel/ethosu/ethosu_drv.c | 13 ++++++++++++-
> > >  drivers/accel/ethosu/ethosu_job.c |  6 +-----
> > >  2 files changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> > > index ae7ebf29cb2f..9ee144c41550 100644
> > > --- a/drivers/accel/ethosu/ethosu_drv.c
> > > +++ b/drivers/accel/ethosu/ethosu_drv.c
> > > @@ -375,9 +375,20 @@ static int ethosu_probe(struct platform_device *pdev)
> > >
> > >  	ret = ethosu_init(ethosudev);
> > >  	if (ret)
> > > -		return ret;
> > > +		goto err_job_fini;
> > >
> > >  	ret = drm_dev_register(&ethosudev->base, 0);
> > > +	if (ret)
> > > +		goto err_sram_free;
> > > +
> > > +	return 0;
> > > +
> > > +err_sram_free:
> > > +	if (ethosudev->sram)
> > > +		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> > > +			      ethosudev->npu_info.sram_size);
> >
> > Does worth add devm_gen_pool_dma_alloc()?
>
> We want this backported to stable, so I think we want it as-is and then
> perhaps later add a helper.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Rob
