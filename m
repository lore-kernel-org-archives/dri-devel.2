Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420A9CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C488C10E4F4;
	Thu, 21 May 2026 13:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIlDF08A";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5105010E476
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLfVjCUcRr0HLQK1ZOpEEgWZVSkqv49kbWgbAO3slCjvmAy7/pxN3mzN8gjr5KALk2DsYOZTacLc3U6oAHJDKLFTXm5rqoMaHW/csimXe5kj8b6dv2BpIdhyfNQ8sQ4+l9sfGyQlVXK819rBCurZRuX3//ocVdgc/9teGQhDXh9QvK0YoY0YHFHs7uH1mzKhRwnJUs3uMg3Mb1AtRs9y9DS13QNeuWwzOJS7VJpTf/n0CHMky6old0yFd4DYNV9ujsFbAzzKAv6rf82KD5lt0v0ChCIKfksadzQNFhd2sKt0GW1Ruheq+QEkGiNHzPnKmyUbFTmm3Ax9VzsaIqtyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/qHPajUp7BaUe8fKM6frDts49BdMLbJr5geq+pYAxo=;
 b=X6C+92KPtS8RmtltAnSlBjaU0VTDWNKyEzuHCxiG8l5e0VwmLGgl304uUKSAwf39UAq2iqf8fLGSb9C2X0fN/RAoR/Y7nv2xhrcyAqIdhvC+LfAd9QkzFgHSxe3JUi3w/x6duTsFqxXf2lX1lWPc9lKRnYVk1LBEMRwHzUNm6SoD50N8PxhFsAHTwHeDECUMuGq4eD5fSBZQZO9ZHxD4ifhz5GAVcnMiziC/M35A5E7L/YqIwfeqBX5RXTjzr7CsvdiBZVhlUqFjiQYzK+POnMWeJ3/Ag99iqzhGarVbiuddeUPBgXL+YWkKayMws24aHYAQSfmKRNFCM8o8Po2GmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/qHPajUp7BaUe8fKM6frDts49BdMLbJr5geq+pYAxo=;
 b=lIlDF08AH5NqT4tjed+IJSzJfgI62xzlTiSwCAfLSmlv0Sgfqgzu5PyOyJA6vt/vffovCjFeizNd8jfrt9h45nYoqrKWZiLCMP3kwFaQIa9WXEVtpSOqN9oKwTJGViw9qtcarCpnFrMW+ql6323QCcdPQ/8fL0JVSfmw8lFN+J0Trp/Kvpmm8uJ3rDK+3Aj+HRJ2FEWE+M81dEAfwSHsm53BA7U67N4BAw/RA4hzR/Lz2u9JU6GUHd6ZxaMGV664sMSjtMakYiMxm/Pb3Wz7hcDlcT14mrwp33UK3Hz2b0jTVk9IDJF5lLaQBuNo2rEtjiVrxSEtD+sqvVGq4saJCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 13:51:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:51:05 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 21 May 2026 22:50:48 +0900
Subject: [PATCH v6 1/7] gpu: nova-core: remove unneeded get_gsp_info proxy
 function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nova-unload-v6-1-65f581c812c9@nvidia.com>
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
In-Reply-To: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 9435e1d9-6aa9-4cd0-1398-08deb73fff12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: oOUXrmjgvGLPfnROGE/j6fmLjGrgVhlyh1AQ2B8wAF2Y7glvI6vWidGCv44MNCN2f4FFFU28H7oKk/jrLs00cyi+aDy1rXICK9BNME3TV+qpCQEDbRi9Lk8vbIJ2WYf3kmgMyD3DBzr9eYGwc7c3CBMEevh+V5mAV+j+rMUpHeIgw0wcNLZW/M5oFovVVlEgpNcgQVRjjBfG6YW+PpKhfE0g+0SkHjTMoLvLr8q6U6GK+bLAlKuByPlrskSFAKpbG9EawM20rcWfTlSpPytMiflTaAHVEMZHkE4RTHiEIMrbnDjoAH6+MMatIO6VBgmlh4iIIZnxc574nrD1fo4CiqmImrAKWks0X3viCvJEpiyME1rowBLOgQX8+NxPsHnf9Rs0OmxNm6vSR8+94iqY6iDo+ReUT092Ot3XxCFD6/AA0LF0UU98bdlF2YFv9yXi03GEtAttlBtopK3TJcinOYp4unB1ZAQxgKl34t3tSQNqGpUYMFv+5w8rekG1h0fes0irrSbDleopd03ANRZY1sw3bNW58xqDwHmmTIRboOqCRpSgjZCAp7DueVJjFxm1bFnmw9EN1kWBgZjG+nt8ZJHWcQkDb2XLDdgqrj6OpMZvHyi+IwZlP9ff9ymbCVU3ZCq1HWqs0Hss547UtI1e5eCs0jyvmGbwLFM52SgFDxSb5vWteEefDdK3v6x98gHn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWFNeE9FNWNjMTQ0ZVREUDNxTFBFRndNU0hwb0tUNHR1NWFvcE44Sm45R0Mx?=
 =?utf-8?B?T1g3aHZRdGZTRVBvOVN1VSt2Rzl6TkNseXhRMmxtMU5ucHBHWVY3NGdhWG4x?=
 =?utf-8?B?QUdBYzV5UXNIU2VQYjcxaVNwYjR6dVZkOUtzYWtBZE9URStaUWwwek13c1Fo?=
 =?utf-8?B?Rkd6RUZkVEwvZGg4QlZaNGJiSzBYdlhjUTF0Y0YwbFJlOFVPNk1aZWJtL3RK?=
 =?utf-8?B?bWh3eFFzbFVGZzQ0Und5UmhPY2kra09BT0NpdmExZGp1VEpoUUN2YldiU3FU?=
 =?utf-8?B?NmMxc3pXbXdaa3ZydFFkRGFhcjBiRHlWMC9SaUJvaHdTSzlUa2d5RnBkUnUw?=
 =?utf-8?B?cDFWVGNsMG42RlJVSXRJeXdQVkFKV0haY1grczY2VGY5ZFVpdnJEUytuWHg5?=
 =?utf-8?B?czBiQmJ6SFlGQU1IUzRlR0pNYXlXSUZXeDBSbTlyREVVWGdtQS94RzlNRTdn?=
 =?utf-8?B?MEtyQ3B6RTRmVmYzVFJzTjltalN4cDVtUnFBS3RNV0RMWVZTOGpSR1VRVEdx?=
 =?utf-8?B?ZERQUWhzVzN2bktxZnJwZGNjbzBiU1JjTGFJS1Q0Z05NV3dXSFMzeU9CdTZO?=
 =?utf-8?B?QU45QjcxTlVpZXdCWDFrVjNQUVd3NHdWZXlvWjZuTklPMUpOakxQcnlVODNR?=
 =?utf-8?B?UFIwUUZKdnIxcW5jZVk2SWtnZEU4WHJHTUtpRFF5akd4aWl5OGtQd2VCTDBK?=
 =?utf-8?B?Y0RXanYwU1ZWdVBoMXlsd04vWjVMaVp4VUhyNm1mSFF4NHBFU3o1VzgzSXE1?=
 =?utf-8?B?clJlK0pMQVA0REVhWVFaSzBhd1gxdmNnRTNhVUVobHZUR3p2cnRDWGw2ZUYy?=
 =?utf-8?B?KzJrMnhUd2FRYlllV05zM3JXaDY2dFlxZ1FEeGhlL3oxVjVabzUyQUVDNW1V?=
 =?utf-8?B?N1Boc0VLZnBBWGtUczU0a28rRnV0U2cwUmE1YVNsYjFRNXFRVy9IYWpWV0xQ?=
 =?utf-8?B?R1V0TWJodFl5clZOYnhvYXFvRjdNbVB6QVYrNXRzdG5ZRm1iOTlWMWhOSXZI?=
 =?utf-8?B?cnhuWGY0QUZlb3BLNkZUWGROTFQvdzllSEpRM2grRTlrYmk3SGwvQ0VkNFNp?=
 =?utf-8?B?SVNIdHlRNmg4VVFDQ0V3ZmU3MXcwMHlPeng1RkhabDM2dVh3WnJqOEZTNFBi?=
 =?utf-8?B?eHpuUFdxb0p6VlBOOG9Kclh4L2hlOG5kYUc4VEFNc1hieEhDRHFBVlc5ejF2?=
 =?utf-8?B?RTJjdWI2YWt5TGROc2lHRzhDTG5Bb3hUZVMwTGkySlBUMjcrZHpoVnR3bGJO?=
 =?utf-8?B?REpZSjFTODJicHJZZHN3QVU1QjluTGhNTFl2bnNmNDdrbTIzZnhhU1RQSlFr?=
 =?utf-8?B?NnVvK3BFdG5uWDlRRzVMQjlyc1h0RFpVajdpb1JYVXJ2ZXlTRVEzNzkzRGx3?=
 =?utf-8?B?QWZsRjQwNTBVT1VxU24wOFJCZ1RFNTFtWk8yVjhucnB3UWxhMEFnbnFia3d3?=
 =?utf-8?B?L25rc0NHMXhWK1V5QmFBMUl0UHkzWEFscG1xblY1Z1Q4cExZQmkvbkprcHZu?=
 =?utf-8?B?U2NIVmZNQ3UxeXQ5RlJEVzR6eUxUbHhIdTNyMnp0d1VGVThrRTRGWUFjMWFP?=
 =?utf-8?B?cXdjMFRrRGg2WlFxVXpYb3pOM0hsSEp2Z3d3dFhkMXYwQWYwbFpnTDVNRUtk?=
 =?utf-8?B?cU4vWmJLd2RjZFVKZG9yTTQ5Qy85eE1yL0x0dDdUZHZPVFRLVUJUMEZuRUdC?=
 =?utf-8?B?em0yTDNvYWpwRUpMUkROVkJMU21oQ2JVR1lIV2wyWitFeGVIT0xGS0tVMit1?=
 =?utf-8?B?Y2E2VUZVSlEzYmZ2YVppS2lHRHNwa3pKaHJzSi9IWlJsYWpWWHlTd0w1RDZ0?=
 =?utf-8?B?LzlDMnhlWnFlcWFJYXVPaElWYWhMdXVzU2V3ZU1QaW5YYkRTWktxenBZaUZX?=
 =?utf-8?B?UGI3TVZwMmVySnVPdUtTd2NGZ0kvSVpmOTg0Wk9VVGNGc1hKQ3M0cjB0OU9o?=
 =?utf-8?B?T3lXd0RlSFBuMk8yamhFU3BKZ1pnWEJGRnJOeGV0SndKSm1hcllVWlo1YnI1?=
 =?utf-8?B?ZXNMYXl5WVlEU3RaOTFzOTdvT1NUeVpJaXNCOFBDZ1BTQ0x1c2RSNGYzZkFK?=
 =?utf-8?B?RWZheHlJMkZmbktnTHQzTG5JL1FPT2FtMXpZRUIzemJUNlBBcm9NQ2xpcDNu?=
 =?utf-8?B?a3p6clVMZFVvUVR5V2tsdXZXSTVtZVNESVpVSVU0djZNaGowR2NOQmo3Yzhn?=
 =?utf-8?B?eHhDcVdieUp0S0pXZGFCcGVpbjNiQkc4bzdVUWNOM1ptanlWdk1oUjN0aVhw?=
 =?utf-8?B?eUtOa2EyWWFrclZmRFZxa3lWNlhoM0VQc3FPMExzQS9jU1V2bS94ODM1N1J4?=
 =?utf-8?B?SFVZbjBJZk5Dcnhsb2c0bisxWnl5dnk4UGhSR3lUaFIyV3R5SEY1a28xcTRa?=
 =?utf-8?Q?CSIWYMftrtJ/Bsfv6WfdWsGnlCk89muiOE996RT9tdqM1?=
X-MS-Exchange-AntiSpam-MessageData-1: MatBal+xe/s2dQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9435e1d9-6aa9-4cd0-1398-08deb73fff12
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:51:02.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoPVZlvru6PRxuJBDZalFDbaa7SivTCDhAyDe/xCBc+aT5Hk7t6pdopgSHhvb/TW+IjliV5movMG6OWZc5lz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

This function was useful before the generic command-queue send methods
got merged, but it is just boilerplate now. Replace it with the correct
sequence to queue the `GetGspStaticInfo` command directly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs     | 2 +-
 drivers/gpu/nova-core/gsp/commands.rs | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index df105ef4b371..e838d61bef50 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -243,7 +243,7 @@ pub(crate) fn boot(
         commands::wait_gsp_init_done(&self.cmdq)?;
 
         // Obtain and display basic GPU information.
-        let info = commands::get_gsp_info(&self.cmdq, bar)?;
+        let info = self.cmdq.send_command(bar, commands::GetGspStaticInfo)?;
         match info.gpu_name() {
             Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 0da5b92f4b27..74a8a79bd2d6 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -18,7 +18,6 @@
 };
 
 use crate::{
-    driver::Bar0,
     gsp::{
         cmdq::{
             Cmdq,
@@ -176,7 +175,7 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
 }
 
 /// The `GetGspStaticInfo` command.
-struct GetGspStaticInfo;
+pub(crate) struct GetGspStaticInfo;
 
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
@@ -232,8 +231,3 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
-
-/// Send the [`GetGspInfo`] command and awaits for its reply.
-pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
-    cmdq.send_command(bar, GetGspStaticInfo)
-}

-- 
2.54.0

