Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85B1CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA83112171;
	Thu, 15 Oct 2026 07:57:07 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC28610E21B;
 Tue, 13 Oct 2026 18:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y80PkwviEy5VJoYasD2Gu9X1D+szOBz759TCM8mc831bgQEVY71+CH5Hts6oczgD8YPUY4aO4UusPyWXJONSfxY+LVpYbdYg5t55ftqH5w8cizATFNdsHr4DWavnQq+ln69rMZbdRNFeSPuVq3Nccnw0tyZ0cBVo5Q84FMtQMGoJf+b4iSD7B7c+vKKU8fuZIh5dzK53Anhp/EHLILGjaNLj6rq5e29ZNNCIYHwtofMi8ZljxWAPbr5V/+kn2/plRncg3L5AGqCKbV7t5FBx8jmPamROF4EAhB/xtcBR2Gsi6iyf+pRQ4PZ8Ndom/1SPEpYGoLcKewfhp0dMbEU8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVIHQjqVoSakUPUuM2JvbCsWTpG9ZApxO6NIP/sSMTc=;
 b=MKEly5MiN4cetZnnlgctFh1jboUI1lNsZ0uXYwgerCuGhJM4xDN3l0wLupsyxUPjQDTRmyLe6xsicYgWaYwldj/HBjomcfjTrimeo0ptATqUSsARCXBgoZRAKhdFqsqhPInuL7h3GpdKDf1NELt4gHEiiJXXORgOlWQMaytnklAY08pxp4yParH/f82Ql9mOxpt/UpwmM+FoWRTxc5eoj0VS6WcZMHOnD1S18fm2LPtoksP1TFdQ8zw1RH6shDsZ+eyS8UJHGU5Ci+qqBTFhlIRNjch5ZEl8JbEvlIF1P3NlfI2mu9MZAFc9okxaMR9Mtblv7HsRoBp0435MC0dnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVIHQjqVoSakUPUuM2JvbCsWTpG9ZApxO6NIP/sSMTc=;
 b=eCn8LsKXiKGtu/ITunYsOLQq8ofSLZjZN8Wxt2y3jx0uEiPkd1jAcb/vwCof5SNwtWw06998VWEA4ERB6GwaC4s0N9GgnOjCDalsvb26OiKSMUwrC3K79cySsg0RK48ulItlz6q7bt3iHCfLtYj0Y3vAHpB9x3+hhsXO6L17f6FqefNmw4QNt0IhwELYPLi3nKxyBhnYMp/SenSBU9wFfeIgsipR6cZU03DI7szjCOWNSZ1v7+DtW8ZkByUMA8vRG1OcTFagKrm/LNUH3+6BKqmjJ9AdUaLhliDHRF8Yzm8UWLR1UTvLbqLSnv50M/RU6uZT2c9gjSBxjRmaiCxuJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from SA1PR01MB8112.prod.exchangelabs.com (2603:10b6:806:325::5) by
 CH3PR01MB8648.prod.exchangelabs.com (2603:10b6:610:1b9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 18:21:25 +0000
Received: from SA1PR01MB8112.prod.exchangelabs.com
 ([fe80::1e71:8f1d:29d1:8217]) by SA1PR01MB8112.prod.exchangelabs.com
 ([fe80::1e71:8f1d:29d1:8217%6]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 18:21:25 +0000
From: Michael Burch <me@michaelburch.net>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/msm/dpu: count the pending frame before kicking it
 off
Date: Tue, 13 Oct 2026 13:21:15 -0500
Message-ID: <20261013182117.759725-1-me@michaelburch.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-170245@kernel.org>
References: <20261013172703.12273-1-me@michaelburch.net>
 <sashiko-outbox-170245@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To SA1PR01MB8112.prod.exchangelabs.com
 (2603:10b6:806:325::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8112:EE_|CH3PR01MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f847a38-3384-4d49-e78f-08df2956ca88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|10067099003|18002099003|3023799007|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: WpmjbCy6s2blDCbK3+0Mbe/qDsm3UTQUIbDwfqzbaTWB/+/mxVtupJfqFBXRV8drb9AsYCdh4+uuPwgnre8gh8ugioLPmX5T2DNeKcNjUM3cx0SyrHPI5cWUWX+5Ie+VUekj+6iV0oDrCtqdBtVLLLBXsnf8RixZH5z3F3T28EAipMLgcAzaYBjD/liG7rDvvPNhbIjwyCqxwTpgxVcxp68Jk+kUWOVDiCSDTkvOsJoRNUbmXGGWD4o0cQfHCgK9Fd0a/Dx2K6QZTWBKJ/KAi6x4bn3c4K7ki2RoZ2QXFq3fkpklFKJL1l3Cv108odCY+93hzJOxw9ky6xxbwRRwLjcIc5IN8Ve+taGG5hgfNQESuLJRBKx1xX+kLPXciAPX0twU+CipfXF2vvK9S6mSxdPJIfSZhdjED7xkLCWlbPX0vkIM+iaMv6Ingq9Gj16D3ZN4ervu1grEAziRvrxoPNljzVUXs0mJq+IjXHdyHXdaOb4v09rpvhpfBH8JYxMauKcNr8xD0U3Ut2GgtFNn4Z6yY3Sarellj5oyRV8f0PBC/W3d0g0poR7K0/t6nlULzhvju5t+FSYwW1DQymcGLrY3a59q7qLS5p3VzvChfsI05kZZYLzC/CiMoxiPKVL7+hU1GfpFUQYmujHv2lq20ZQdGDGQuJvPrCyrXA9Ooek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR01MB8112.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zR56b6Qmc2eD72Id0WQgMHMbcPPzGcQIiIuQb13BeJZaWxLQSNAiqlY8R19G?=
 =?us-ascii?Q?ChAq11s3HKtWc6/+yxQyBX875FYsaMwSsfugos22WHMJf5KcQ6aVL6st1bfI?=
 =?us-ascii?Q?o3ypCqpxBDvK2U23VxeSD/dGWC2O0resZ0P/45XnLRRCbrg/P9PYCq8il3DY?=
 =?us-ascii?Q?gwLM1lur6LVo8K38jAYTGhBYAsmze9YMKz7lEGWlf8oCKs5CG77CSgoZDMyp?=
 =?us-ascii?Q?NWHEFBVrNB9qu71wczNhDueleZpGvryX74eI/tiOCrQVDUjaRrwXVTMPLA7+?=
 =?us-ascii?Q?Z23O1uaUUCOuscHawA57qFQ59ABuVvFUxoolD0MTugHiOnBfa+Z9k9zyEDcn?=
 =?us-ascii?Q?m+AQ6tiSdLVpueCaS9x+8k2TdKqXKmBbyFMgU9K9YrvWHxXRHXFk7xCwJMCe?=
 =?us-ascii?Q?EbWtr9axUS4R1wmMplJdZ9uOfikdx+frV7zoyKGxZVqDewTbVgZargM5Zavf?=
 =?us-ascii?Q?ZLgW7+H89PT4oLuKJHaZj7sb0DDpuygRsWRZXi/Sfr7Oyv25SViWf7RdfiAO?=
 =?us-ascii?Q?r/n9kg268XHSANFjXsrl8/CxbxnsJRypLjLkevChhdX8LyjxSENgESkfkQ2N?=
 =?us-ascii?Q?xIbJIZMCJoVVQnII7UnCtpAV59N6bRiQGdOodn/1113Deni3aZCCZ0T6iLrH?=
 =?us-ascii?Q?R5nBxwEtmWYTu5jSF8yQFNpknvHOr5K0XPElnvMPNOldBvyTMIfALOWtl+ss?=
 =?us-ascii?Q?S4EY+q/Z3ifQCXoPwt2jPUB29UvThQ11XVTcKE5g/mKdmcfSersaKjkHXLoj?=
 =?us-ascii?Q?g2BIK7DWA9Z9Bvc0x+/ua2MVCfCtsi6NVZZMpUlpFq4ESU0iPz/b8YpBWGL5?=
 =?us-ascii?Q?4zuydhZGEb49qL5NzRlz6CWFmxqDyB8VNQjNHIXF7QkY7ES3yvM6e6cJFfNN?=
 =?us-ascii?Q?ElqN8nQocJTjSk6DmIt9VYe5uRIuiecNV/Em0g4MCDNV5BoMiwdkSt7kAJjj?=
 =?us-ascii?Q?vg7/zRN3tB/CC70AI0MvlD04XSt5IidIUBVt7p6bSJdXyzmCKUG8GC1Scn4t?=
 =?us-ascii?Q?IKtTd0snQaoLMRKwt8pbbncjJB7SWRDQrhJm0jHu0Hte1gUTdBg3RV4VIyJr?=
 =?us-ascii?Q?AZv9eyuiQ9hYrk3avYLd4x8R9RigZ2rqki2fCGvrKLNey8B4jkPNQKQbFTcM?=
 =?us-ascii?Q?93RG6Rof/8Ps1TyUP/1ir/G01WN9Qnjg0Mw0W5rM+FfPTLe4M3a2Bhww4k/E?=
 =?us-ascii?Q?qA9YJmu0BUDBN6YtUK5qSA5PyW1xPLaZX8LXgQ+ljWJPOpZzBCIFBnJG7RSq?=
 =?us-ascii?Q?/jGfGBIPb13lMoDh5VU4vLJ4z9xUsSz5Dw/Ko6JEOAy8Rj4fhQPvw7/1POYx?=
 =?us-ascii?Q?lh60Is4rG42GUSq9okKGsrhAa91Ebw6Z6zDUageA0P3a9LgRq/r+YilY/yEW?=
 =?us-ascii?Q?fm3cFRM1UmicWKJ6ObvkZRsf8yrFqQTirfZ1DmSp9mtVHt/GcFUqE/TttGrM?=
 =?us-ascii?Q?kJa97vSqgzKNG/GAxuTlbWIBXqnQ/qDZmIvptVo7gkzSjp0S8dINE0rMUm0r?=
 =?us-ascii?Q?xcDX3TUPa5/O7bN0vUBLkZ70QoYyReVuCWnwqFjnxWefoY+zstvgb/nJgd5E?=
 =?us-ascii?Q?4bSpVBQBdTPiD07m1PrhTTorWO8r6rAvJrIhrO3xDBdGO1LJL6ZxV8dwzU1B?=
 =?us-ascii?Q?Vdzx/8KtLFknshUz/IEBTFJ6Pifq/9a0Ti5Wtnhy3gYauixgGxbVZIniXPwf?=
 =?us-ascii?Q?N2uhee1ktB7+SJepE5Qrsp8yBkezBNYeSa7EyC6bTQz0mHhEn42aK9tPq80z?=
 =?us-ascii?Q?dkQkyVGW9g=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f847a38-3384-4d49-e78f-08df2956ca88
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8112.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:21:25.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJc738aIZo72nSaWWKSUIvoxsodFzycIGzuVamCKL4wNgTSFKJoDweeT3Y7DiLxKgro+4cTKb3QGD+n0bS677g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8648
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On Tue, Oct 13, 2026, sashiko-bot@kernel.org wrote:
> > +	dpu_crtc_count_pending_frame(crtc);
> > +
> >  	/*
> >  	 * Kickoff real time encoder last as it's the encoder that
> >  	 * will do the flush
> >  	 */
> >  	dpu_encoder_kickoff(wb_encoder);
> >  	dpu_encoder_kickoff(rt_encoder);
>
> Does this code introduce an unbalanced decrement of frame_pending?
>
> In dpu_crtc_kickoff_clone_mode(), dpu_crtc_count_pending_frame() increments
> frame_pending once per CRTC commit. However, the function subsequently kicks
> off both wb_encoder and rt_encoder independently.
[...]
> If multiple clone-mode commits are interleaved, could the second event from an
> earlier commit arrive after the next commit sets frame_pending to 1?

Yes, the accounting is unbalanced in clone mode, but it is not
introduced by this patch. Without it, dpu_crtc_commit_kickoff() also
counts one frame per commit, and both the writeback and the real-time
encoder report FRAME_EVENT_DONE (and, on a frame-done timeout,
FRAME_EVENT_ERROR) to the CRTC. The patch changes where the frame is
counted, not how many times, so clone mode needs a separate fix.

The encoder already identifies the writeback encoder of a clone-mode
CRTC: dpu_encoder_kickoff() skips its flush when
drm_enc->encoder_type == DRM_MODE_ENCODER_VIRTUAL && dpu_enc->cwb_mask.
Applying the same test in dpu_encoder_frame_done_callback() and
dpu_encoder_frame_done_timeout(), so that only the real-time encoder
reports to the CRTC, would keep one event per counted frame. The
writeback job is still completed through
drm_writeback_signal_completion(). Jessica, does that fit the CWB
design?

I cannot test this here. dpu_encoder_get_clones() pairs writeback only
with DSI encoders, so on X1E80100, where the panel is eDP, no encoder
can share a CRTC with writeback and the DRM core rejects such a commit.
That also corrects my test notes: this machine does expose a Writeback
connector (WB_2); what it cannot do is clone mode.

Michael
