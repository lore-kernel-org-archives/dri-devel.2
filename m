Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876ABCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEF110F409;
	Fri, 15 May 2026 06:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKX5Grbf";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE1F10F40C
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2YGs48gSkxdlErJ7yOyVDHlZPR9cK0F+YEoTNZ+aA4FxWTKzUv6hfQrkzck5RW4/Uy0fratNZOJEmfEVgxcxdBoLtg6svW61WNqsZMEiav7sZyC061Gwq1tQMuV7ghEVw1mIsRHdP/0mLnyLoiybdSU3nzHkoivEYIHv6V5dMWrYMA4DdgHypHDEBMJ+Zz7c3JG//bvTW0FuDqQm/NKNZxLme84/GkuOQPbnQxz0pQskHjYcAFxmtMFLz21owPjYFY0PPLamSa52b5QHfjzOWJqz/e2BWjb/9k6xemWL9W0z4UfYSVIzNQvNf8AQ0FDOvVoKzVRgXTfkRoSKOFo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/qHPajUp7BaUe8fKM6frDts49BdMLbJr5geq+pYAxo=;
 b=Pbti0YmnaABs3Z3+p+dbHx1ZWscEsPvL1BxU0H6/Fh6xwrmVEykMejrndU+ZHdDu49Id7NcSzocdpD9K+PQb11T/NGblbqCewhN9wdXWBfUbTjW6BA7isGSV72M+lmexQZgeQjx6Hp7xfFJ4l2eluaAhu8ULx+LEFIYg4Y83GmN3yhOhKqjXBagu5kiqTWYpW1d26b+Nn1gXvFCij5HLraZUl+R5kq3g5Cq8AHLnNEMSQrzjJxjUbHD1A6JAZ8yQYD44q9IGbb3atTeO+kTZrSkHHzk+nOYGTpnpf+1Eoi6iBPadyib7c2ht5VtCOAKXjHQIP84b7vI62CP+2ZP3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/qHPajUp7BaUe8fKM6frDts49BdMLbJr5geq+pYAxo=;
 b=rKX5Grbf8d2hD5+z9oZs98Y06c4g2Bn8Ru3yIyNhiEshi4Mf0zoNDr0mPGUNLj49mwVyaXSnc6Xz724VJoiqEnci13ayr9TPrGFxM8Q+LGEucavntE4tQswhgrJJ5y0CoopECV2LLqPvKh3ZCPiqxe8mxm6THDQAsteDMWjG9i1tkBllztMSxSc3ZuNlf155Xh9sdTu/OXbASbqVjajmPcYSC3Xkn5ZraSUVfrUn1mjNiK1AtIC1jWA7dNAbZLI2PFdswM1aCfL1sFUGc8NGyGcAPBmrXSS7Mg/UmlTZivkCYL/jfqgmWx3Ix37zIsckA5sJYKVHsD0JRt8aWbE2gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:12:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:12:51 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:27 +0900
Subject: [PATCH v5 1/7] gpu: nova-core: remove unneeded get_gsp_info proxy
 function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-1-c4d6250ad160@nvidia.com>
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OSTPR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:604:21a::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: b7595ea7-343f-461b-d05b-08deb248fe56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: iEboKaXo2t/91pj97r6wNg/IPevRVMi86XFLZuM2uZVdPDddG9tF1EAkVEuEVA7IWZfc0zgR9MRxyQzKpUUCN3w5MD7nUGAMsOKHk4pDMuumWLrxGeXY1IfQiV4RuQ7VAoDpeofJJLamkAGFSaRLXtiZbi1ciNvNhzMFXXQY4IvTvrR01FzjJcU4pXIvcgPkbwUMlYjl3WS20UzORQTLhWrBmY6s6/33IQ2wbA85QQ86BAWEPqyLv5K/Ixs9L21KhayJOMusPu9xPLphBqQHb8CidkkufuJAMEk7WBJbJNb7c5tHbt7TuAiqLefzGy6HcJjBDCZf7PY8Be4tNJpwqidjH9QCP+PTQr99+WwNScO4Etv1DDVFCNxMXIjyAZdtQj9DJBxSXdFsWyRCShRRoFMW+iP3B3uh0V/1I6pKYgDpZWkhZaubj8Q1flcIHdByS+0fLI/6rX+B9UXZUU6QMRd2RITe8kV2j3ZwzOR69YElEiKoIOQN8aFkhm2YKd25kWtM0nWlztzDg1ZN25xudSlWnRpSmv15i7STcMhGkZQjSWTusdL6daeE8PF3/WUROjTeqLf24MTmRF3IIrVYFCiVO+WLUNup/G48rQC7e76TmaQY9v0Ug1lTNiFjEbw6WuuxauUdqm4bnu3iI0//tijkyICodXv+qUfBDvK/urTHZRgZiMXgWvnaaAKstV+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blVRa1lHakRISFVYOUhqN3Q5Z0VkV0lkOXM2Qndqb2h4ajFsU1VpUGhQeTc4?=
 =?utf-8?B?dlduZEhKRnY2SXh5dnZ5Vy8yZTl0d1JiUS9QeWg2aXFyYTRtVHVvdHRCWi9i?=
 =?utf-8?B?N0wydlFObEtPYWxNRnZnN2lIdXF0WnFLZ0VrcFF2MU1VQUFWZG9oWlloU2pp?=
 =?utf-8?B?bndyTXgrMjN3cFlDS3JQakg2KzZpdmVlTmVUekZqaW1sUnNyRlFmSWczVUJw?=
 =?utf-8?B?TFhWZjJkMVZ5ekw5U0pSUnA2cEswTVF4NEtUMGN3VjZMbVhkek9JTlVhUG0w?=
 =?utf-8?B?emNuZkZtaHdMNjhXM0ZZellKYW9LWW5oc1pzc1U4cXU4TVdibWx2VTBvTjBM?=
 =?utf-8?B?ZitvK2FUVlhiREF6OU9iNEhQbWwrdGtMNlUwQUJveVlRc0U5R0ZKZTFRL3hw?=
 =?utf-8?B?dk9peDFFWXY5SnRjYk1lNmdJY3dHRm1pWU0yWWRYVFh5c21lbmI5cFVTNDNE?=
 =?utf-8?B?L2c0MHJMcWhTOHc5eEJuWkRIRjJsZGhEc1B2TGVhZ093b1dWcVorVys0Sjl0?=
 =?utf-8?B?MDBzQmpZc01FckVpc1c3bFMxT09ua2o2SjkxNkdlUkp0ekN1UnVndEtQTUhs?=
 =?utf-8?B?eDl4NlVORzlzREhnK0lQaml1dlUyWkV6UkdlOEYwZnJxaUFtWG9Nb2tqcU1p?=
 =?utf-8?B?RFRNR29CN3g5RHR1WVJ4cFl2ZzR3cS9pSjRkVTZhMTNsRjQya1M3Ylp4dk5l?=
 =?utf-8?B?VVdVQUU0dlBvVG1OVzJPSzJZZ1YzMlBjdUsxNmc3c3hVNjE3dS9HclRjMHRu?=
 =?utf-8?B?L1c3aXowcjdCbGZBNkM5NnUwbHpXdURkMGVZMW0ycGtNVmorQXNoZWdjeDdL?=
 =?utf-8?B?YmU1NXNYVTRDeTI0UC9Ecm05ekhTa3NBQnFHZk9CLzNFdXllWUNSQytjZHNU?=
 =?utf-8?B?NnhzZVgraU8zcU1uUWVvcU5RWGFLVTJzbHlpOEswSzlHTkdCaVRuY00zaFZj?=
 =?utf-8?B?Tlk2WG10VXRpSll6RE1rVDM0SWFOUlpzUFJDYjNlVFBUSm0vRFE5eC9vbHZR?=
 =?utf-8?B?aVB3NnNFUkJaV2h1cmdBZFZIV1FkVkhybWpxMmJ3SnoyM2N6c1pGSm1zdElo?=
 =?utf-8?B?UzJkY1djdkNTYzBrcW02QTEyclRza1pHdXFBa1FOTFBxQkQ0WWhNU1FkbUtW?=
 =?utf-8?B?Z2dMUFJjdHUrdkFsRjI0RzNSbDZ0Z0lveHlTRnV0eUlxbUQ4MEozeVNOSWVJ?=
 =?utf-8?B?VTNwRFhoREJPRWhvMUlmZ1JheFJEVSttcXZ5VktpcXdTS2huUW0rem5odGov?=
 =?utf-8?B?TFBDTzhkc2djQUZ2bXVLVlQzdzBqcTRVblVTaExiUUx4UTE5dHFsMDNLZmdF?=
 =?utf-8?B?VWJ1QlFjZWlwdFdGVVZKaC9mVEUxTU5HZURNcm5DUGQ1V1RDb1BzNHJuUmpz?=
 =?utf-8?B?S28wS1lIcVEzREw4K0hOa2dsQk8wVFNyeGhEQmVlQjI2aFBNaEoxa3BNbktL?=
 =?utf-8?B?YlRQaXFuQWUxTDNlRTd1TXhhNVB4cDFYcVE3ZU91SWFzb0VuQTUvcUo3NUxs?=
 =?utf-8?B?M1o1Z1F4TlllRFZoOEdJSUlpT1lSZzRHbHU4RU05TDlOdG1QZ3krRS9kTVdH?=
 =?utf-8?B?cGRCUFgwTHhoVGVFU2xZSlFFVkdzMGFqM0RHaS8xSnlKcUZuZGUyNnpQazhq?=
 =?utf-8?B?bnlaOWhHK1k4TkxqZUxQdnByZ2RSR2NjV2loREJscCtndVQyQkxQeWNNTXJG?=
 =?utf-8?B?NTF0emVyeS95aDFLNzJ0aWVGeUhMZW1yK2g4cWFjZkdDVHZlWSsxYUZEZzRU?=
 =?utf-8?B?Qi9uS3BvZ0d5TGFRRHdlWVdUaUlnN1dlaW9nY0F3U3BjaEdLbnN1a01VWXNM?=
 =?utf-8?B?dWtRZ09vdFAweEhTVXdDOXhwYitQTUhuOWlUZHRGb09MSlNYazdHUFhkSkNL?=
 =?utf-8?B?RDBEeHlGL3FKNlhtVk1iY0ZaTTBXRTBLbDdFRzFOczdQeE84Qk4vZlFJa0p2?=
 =?utf-8?B?MDdWZmlCdlNKV2JFT0hmZFdUMC8rQ0hMdXBpMm9uaE9ZQ0hEcXNJMVJmdVN4?=
 =?utf-8?B?Mmp3NkRrcVEzOGpXcVprZFIrdkg3OGh4bFRhR3lDK0EyT3RYZHJ4aFFocnlO?=
 =?utf-8?B?eFB3RHpKM3N0NmpMZHh0dk9wRG50ajRrMUdHeExOMHEzZFY1Uk5YRmUxRmd0?=
 =?utf-8?B?THZ6aTNiTDlIV2p3a0NUUDhDRmxxTXgyTElXeUR2WEJzeHJwUEU3czMzbkJ2?=
 =?utf-8?B?UE5zVjFUVkhrUVV6WjJJQ0RHam4vbGR0czV3U2VoUW5WeGc3RHQvdTNRS1pB?=
 =?utf-8?B?SEpET2J5eXNEYWpnUEtxUndTUUdoT2JpSWovQzFOZGhpcTFkK2RJRGVWbnNn?=
 =?utf-8?B?d0U5TjBYUFFrMTBVeEpNTDJRdFhsclNPUHphQW1SOXJYWGoyMm5MUHQvYjh2?=
 =?utf-8?Q?T33w/iPV4/88RAFngaFTaA4Anj9kxoUSCV1BSl1u3Dpe8?=
X-MS-Exchange-AntiSpam-MessageData-1: iQYmTxqpPJb1jA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7595ea7-343f-461b-d05b-08deb248fe56
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:12:51.0566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh2H17aoQiCqzrYCeCkUE9TyxSG1RTS0XiFQZOKikg5KANjHWDfCxcaZ+JAMLMVJCs8HTBxsLEGSxjQZvBmfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

