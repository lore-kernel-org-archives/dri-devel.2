Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA0BCD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 01:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DA110E027;
	Sat, 23 May 2026 01:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BX2EHCWz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C66810E027
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 01:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNKqqWOIKf6ONbVcieJmSU2LkuApXX0q5USBiOH7gyVnkCBAcBCyDCade/TaTgIt2cKHpAuI4RFPZAKtp/jzWZbTCB0qssV1ZbneuzzX0NSoxHYw4pUbC/fPFMLufNw7TkojsrLl/rRzREqWZaboiCgXGISs+vRnkJEpXS0U9hY108SHWXX9bBCeXbwh4rQ2TBss7VyomaQAUVfcybtsOG2Oa43ZWBFDrQhUN6jZZ/GBLTCjTvERVcGyU6TLHsRh2BL7Rf9YU4yv+RRxxR5niscYe5qs08ccr2nNnHPyV41J3JrNccVpEJSFEUaYTSrn9S3ucQ74YbWRWqFq3O3UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0H9mfSmmesW/ETR2Cby4bZoI1Zxp5JG/zLeEJZ9cDs=;
 b=W46RsA0y2fDa7KH26wqJ81OvQFEvL9ikwUZk9KYsMgTiCBST87irOTpLv4TRB7fj39pHkuABCXWt8Qhpn0YvtOYdC8M+9wQpwJSCnKDzE1ho9CHzxbudGl04j3sWJIts6R1mf75idby9Uz9mecWVORG1vj5sATfiFQWTWR2gmCcoxgC0qYIjTY3UchZRpNSLuBSTsWob/LCwWooBqIWjxUql/VKR+hGIkZ8VvuY6EGE3RipyWw7IIyVWDrZnqNt1Kb4k6410ypJ/t+vo39MJD+SIy9F+F1Ea15ijhzzQsfriAp33CFeifRpAL6R5W7eFqX29zJ5wtF91+D88o8a/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0H9mfSmmesW/ETR2Cby4bZoI1Zxp5JG/zLeEJZ9cDs=;
 b=BX2EHCWzNLP3HRoU7uGzk6r23Z2l3nIFlpJfn5TExXIqJPRF8bnvCWWqBdlAozj18cLDIajbwQzaIvS0fPaHluj/yM9wWJBmpB7TUfLvLqnVumTRwnG9F19MJ/rdhF75xaTHAeNO/dXYN4xmHUrb8dwUxDTMHk7aJcf9LxQOtbAUjpsPNymNfsWFHUOF0sJO10I6m+hTkj3vrsZ/StSZDOSua4stQ0bN1Eyz3ANGbTQSLMEoyjPIcX4PW+NKZDjkof8UuSNoP4Ti55Cbo4bJJKDrcIlx30AOWv03ESMxck3nnrMwqRsAsy3vje7ZWPSgHD32oghi2dh3y9Yuij7hpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 01:11:20 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 01:11:20 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH v2] dma-buf: set SB_I_NOEXEC and SB_I_NODEV on the pseudo
 filesystem
Date: Fri, 22 May 2026 18:11:17 -0700
Message-ID: <20260523011117.121390-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de25eaa-2437-44ca-519b-08deb86832c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: kGwRktcbnwbD3UPJPBQSQV+eNMtzdyR6EFcv3QkvtvnJv5MydnJPq+S7yi+VvDxhLe1lZUu6D8b1gqQK5rkyYoNGIY0VPFCVnWecbEcEvwqdA1mcUoo/lUei8m2etrCl08z3ne+7T++O/CZLeoxga19aL4nqyUiYpok/MaWCbrlZLNXdNZMhB8rUTO3UznWp3kTA3InNhTDYeAdkAhwHmNw30+g7qpLlf7Q3oJB9P+CsudTg3dS2kJz1cKs9qKWuA7Jr8oGY9yEdkq+HKpBpf5HZLUscfYrqj2Mwn+Ioy+yOt4Kyp1SxMl8UY6F5X8kSbKdBzkVpfGjFm9F3Nj/0e1AokJT7S4HHkhR09yQu6dzgKSzFXIOzgu0R7FFhPqF24nq0LrYNyENc5NRJMX/kj8+5uhk0Img3KUQKTUPzeayGS2wjx97Zdj2LbKOSMjrrM6Asv+APCNieYSCMt9QsAlFXGy0F4rn+blF+am4IE8aBE1QONQrKcSYGwPlhYO0+dkZ9zV7TBPO5slQj4EDB2cI2a27/PM2NLkCu7sT8hrQkDWrzb8mykBpEWTkxM1h3LlfrNDJJJ9WBGEDDRWJOSlXaXNirtirRs7BDnxOmfTvZ5nEGF5AJv1AoqkxWzpcsKrq/PAZ7sK7UAQHPBMDo/ISpi42mw6/RwtPfSnFjlMnmq5Wp/485240muPeK5L/d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVz8aRYR6m8mHFMOzEE5XfEY8U+O15TZirYXfnUFiFDl+2W67WW8504iZ3kY?=
 =?us-ascii?Q?y+jGi6IMzvB0ir5VkPHi9qoeJkaMCGAt3IVdPTW0igfWjfF+ALZBOqgKgqRI?=
 =?us-ascii?Q?DHM4refTngb/n47tOy+3j80KGzay8HLshqyq/NnZa1ddUutlh20aa62L/8jR?=
 =?us-ascii?Q?mhaVhYZcSuo/re4Gs5I+Y4FP3am39xqyTw/2ZG41BpZldOIHsNfNwQKtzkXz?=
 =?us-ascii?Q?U7+svhHUOvglXsow3UL7GUSvs2gboXsWvF+shoBrh3/jTwuVgQPs0K8YUi7h?=
 =?us-ascii?Q?ePufNPJxWY3KvpiBJVl1o9PGNGAPwBFS56s8DF4tD4tPuNk4sYo9qAJKpszD?=
 =?us-ascii?Q?0txd7FE6znmEAh44NmQEXT2xSwsA6T8vQbxP12gz66a26EoeQOwSC2fqJLMk?=
 =?us-ascii?Q?jY7wpDC8k+wEfwlEMC7wRMV06HhrJ1kbfdnrz9FprKd0YKxRrVwypgj4VDrY?=
 =?us-ascii?Q?0F2V0cxx37V02qK2c1EPFGbK3XjDLW6TmMBTHc7Ks/dko7qWr9+hO0ja8BeQ?=
 =?us-ascii?Q?GMHrYYuP74cHGeHKDuDfrPmN1+Pv8Gie4HYLhz8x5AXGyr/5p7kFU/zZ34Km?=
 =?us-ascii?Q?uBppysIit/uPAuYD1ITCEc/gYnHq2MYjAWVP4JTdGwt9yLOnp8Gx6hLMwd1a?=
 =?us-ascii?Q?UFbKndZgg6ya4P2shqoh3FQ26rR3T1o3CL/2zEkPejuMaSw+ZLoT+sjJHxEm?=
 =?us-ascii?Q?/dfLF7ALU57aHdgAQG2vLz4IT9VWxwX+R1cEiHN4Zxqc/EOBLGJJ2DHknBRU?=
 =?us-ascii?Q?6zgLxN2JZyEO+ykRjXEZ8pH/EUbtDuLQKfO7hC6Q5KSRDFvJ24JH3Ok3S9bz?=
 =?us-ascii?Q?vaEIOHaKqxexFF+n2haBV5GsDabDdLP+rZwHjtPFaHqrc74K2gPaLtrGAM0n?=
 =?us-ascii?Q?5B7uXpqQp7gJVdObE2uIlMUKwxQ+cYdt40UWxnIl8Q2rMwG/GPlzJpxWDayL?=
 =?us-ascii?Q?Q/ocTLwl7tTfM3ijXFK2EYbwiCl81/1OzgBLT0p3d/HUL6eeSXrVcI2p0Cks?=
 =?us-ascii?Q?/0HhMzNA853wDh9UjZGsVBIV9qLCXivIbm9cReobOTR1gYyNgWCIjcPSFdkr?=
 =?us-ascii?Q?l0CEeG0prC56Y3MtOe3Ma/yEjjmrDNBBUJIX77Bi2jfss8XEdBgw92YS5gCL?=
 =?us-ascii?Q?W6jy9PcJHhOnflzZtEuH+jK1/KbX0/vIuUysluIKIM9ps0Kqq7/JesZYjsKP?=
 =?us-ascii?Q?bOdDdYtlNjQsCcNJF6DuNSOfwKluQ2Dr8eZ9oBWMPtB+duF29krl7Jd/Za62?=
 =?us-ascii?Q?ws6wXr/9MIAACLo1JWM8kwBd0PRSor+qcFXwMviXHWhUAH9Vgay5WQssktWs?=
 =?us-ascii?Q?GmSB5uH9+JursD4LhkZ1xM7Sj4NGiowarP7cUn7pliE+EzpCaWFG9jKz0VeN?=
 =?us-ascii?Q?ip+r00gnid5U37Zx2UT/K6HB2NPYV8t7NJi9C3k3I3PuQh5yNrr+SmmHWfPh?=
 =?us-ascii?Q?DoGDXxrv1/i0YzbWTflAq5uf7f5psEWCdKCX3MbXGU+0k+YwKTGFzdmaS8Ns?=
 =?us-ascii?Q?EIUrMFzrBJbXs6jNiMkRMraXc4+b64c6SFQQIjFMqBraInqA7PJ3FK2A/WPa?=
 =?us-ascii?Q?n2dqXQ/3qutlfxC40TyAOG4xN8GlMJIXs+9qsj2sOxeYXfk/8J52kiPhsggS?=
 =?us-ascii?Q?ih5iXLigb96hK+fytFnrZBfAaKnYCjrv811W19X/DXtkIE+Wo8VeWJdHT2aY?=
 =?us-ascii?Q?lT7CjCS4ZhC6fIiOUcinG79oTP5tSA/Kf4IKVFxuxky/IPnSuyE9BPMybQf7?=
 =?us-ascii?Q?w5UxOe8Kbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de25eaa-2437-44ca-519b-08deb86832c1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 01:11:20.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4K5CdJbbXGztqZcfObpuHkC/KARBweJ93osgZHubb3futfZB2Fc+SkKDmd6NRcH+MOSr9QoLJua2NMVFF1/9cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

The dma-buf pseudo filesystem dispenses S_ANON_INODE inodes via
alloc_anon_inode() but never sets SB_I_NOEXEC on its superblock.
Since commit 1e7ab6f67824 ("anon_inode: rework assertions") in 6.17,
path_noexec() warns on exactly that combination, so an mmap() on any
dma-buf fd trips the warning:

  WARNING: CPU: 11 PID: 121813 at fs/exec.c:118 path_noexec+0x47/0x50
   do_mmap+0x2b5/0x680
   vm_mmap_pgoff+0x129/0x210
   ksys_mmap_pgoff+0x177/0x240
   __x64_sys_mmap+0x33/0x70

dma-bufs have no business being executable, which is the invariant
that the new assertion is enforcing. Set SB_I_NOEXEC. Also set
SB_I_NODEV, since the pseudo filesystem creates no device nodes.

Reproducer on a CONFIG_DEBUG_VFS=y kernel:

  make -C tools/testing/selftests/dmabuf-heaps
  sudo ./tools/testing/selftests/dmabuf-heaps/dmabuf-heap -t system

The selftest allocates from /dev/dma_heap/system and mmaps the
returned fd, which trips the warning without this patch.

Fixes: 1e7ab6f67824 ("anon_inode: rework assertions")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v1:

   * Also set SB_I_NODEV (suggested by Christian Brauner).
   * Added Christian Brauner's Reviewed-by tag (thanks!)


 drivers/dma-buf/dma-buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c6..ea1ddd4293b2 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -216,6 +216,8 @@ static int dma_buf_fs_init_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dops = &dma_buf_dentry_ops;
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
 	return 0;
 }
 

base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
-- 
2.54.0

