Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEBF9EDD3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA4E10EA3C;
	Wed, 22 Apr 2026 13:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oNh9FSbr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C429110EA46
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flSbWIuwXKHURBch/hfJEI33JLBH/doPop4VcFoLFBTzsABVEin5cMCM+gquZIBrqet6nA0aB89cvKo+tlGMrqQtdYHCt//0TQVxlh09gydQzRvyZ3gRe9Z8bCidhpQsvHppWbBArUyUOMwLrbs2gTf/4kRHiMG66monNAef9mA+MqUnNM+JvIudaz8U+0tX1XTLnBUdDMBTPo+ovdmsypdDubWBoaKeJE1AJLsTmCEKxFTkDlZaI9LeMVMmLMAzpLDXI1BtnJC8LneRcaSSCwSIfjDCvzbHU/sgtmSVstJn1HQIntFnkRVX3ui2m8XwFvV5Iy34D646K2uzSpQ84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU+xgcFbPdC6SH9Rz6la9XdD4fP49qgz8gXtUnasCis=;
 b=jfonCzl7ffmvTvuM6pWuc0udz/rH8DOUC+q043LW+60rwtnkbtXl+26ETkaNAo3+b07be2kp2R00WZrnhX6BDwIUudpf8Mrz15VwlHDB4TTYq2p6cZwhg6yluUG2gNLRcWZJyzRot6KvRvWnJrvWU5b4io595W86hC472N896SgP6JPBKKWrb2v4FMGlJb5p4eYTCqkLsOzfJvOpzYI1UDOxodnoM5oUSGW/Wrr8Aln+wDeo1MnHjEUisUPtbgJqg4YS2mfHf/ZU4rnvjfQgn/r4KYjscRFFAkx2Bn22lvrgiRqXFn7R3lCyWT9N3fruYvVeLQ5I0ve8G83bTvGHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU+xgcFbPdC6SH9Rz6la9XdD4fP49qgz8gXtUnasCis=;
 b=oNh9FSbrNnXboj5JVQhn7XVyTQsO5MD6uJ68kuVgIFaNJRu87NlPsVR7vxm1uUu3t98ranSh9U7Z3be0eMd0dlxOmKa5woP0Hpbsf5WFgOs5cplIVDLcuKtGn46l0JuxYI7x28iwhHRShAR5WyjcZWYJi5gc7X2sjkf6B10N2NNTUjW7FrxxbTEsWWk1qw/Q/HKuVmW3wI39qLHTx0qPKcMS6ZU2d9vKUG7PVusMEg/jn+N8ejk8B/zh3Yfr0SaFS0eWp+GdJADpood64d3Lkkn7ih5HuKl84Zu/NvFocaSnB+rwt0WivjoMObggk8f60I8YYlP1/hE0n9twHKymVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:41:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:41:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Apr 2026 22:40:56 +0900
Subject: [PATCH v3 6/6] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-nova-unload-v3-6-1d2c81bd3ced@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a15c13-5cfa-4cf8-89ef-08dea074d7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EBfKE1iPDdQzByyvCbz+JzhlNnNr8e1IwWeCFqnZy+rxmjUB1HFIKl6/OpPvoRyNiMp23oK44iNnQ9SgPI96mfBrTAl0xDDDWxV31WynGCtddUJMMkEC4pBaowgoLlwTcDGeXMHc0VDOCf8rpUAX/Yqg7r2J0Xo2ge9br4svMOBFhrgOz+2ZavhaZ49H6HmbDxGL2kRytmQusm5bLT1/mifK6HsuIT1sqIc5sKmB05gEAgt6RpJKHpXrT6t1c4eO45YWUhrUq02//gSs28Fjnf+qJfwRsHQ2PZkWUViwmV9zfqtOfpTKTKjqD1/EpEC2x9wpaoe5t34seOZEpn30CksG2L9GX8BxuFlchKbzJ5nQQSZ45yccQEANQlSg/VdEMirJLmUsB57MRF2li2Q5whOSz4vaVEkdj3LTXTW+9fObw6f/2Oz6pjI/YufPDxWJuU5yhOe289K91seWWWf65P5iyTZ2P1+JE7+gcRef5dr0wRwUg7jy69bXm6aZu+95ay3fp4huvVQv8tbqcVIr7nG7TOF9JqmUaKdPtxe4T3WdNFrxM1r7WLAz09Kz/0FaaeoNxZ9ZrEuxM3PY++q8neCo0SCp88r6Qu9qsLVYEukWRLuZ9J7MvnSfjVZh0ahZc1NA9uSFjLCkD6X60IfRwip9DAJeqw4/hmPpKYGvA7aV7CY8ReUQmPWHFpfeAIVxkj7p5eMRksPwllZ3bMDdPa++JSP0oczhnhhlNkoqxvBFpVZ54O+PKfCnZhR3b2Da1AFHprXqVBptBni4HwJ8ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWY1Y3BPdHE3QXlJcDR5SWdCSlhUT3NEeVZqSEtrTGhMdy9JRnhtYi9zbkRN?=
 =?utf-8?B?cHZ5TjR0aG9OVHBhM0oxNDlsaW5yZE16U3RDL0RwSkdlR3I4ZEt2WGNiL1Fj?=
 =?utf-8?B?RWRxV2tlYi9zcjZHbENDSUVFMWdCNmxMTysxc1NIaU8zMElGRlhnNzZjMS8w?=
 =?utf-8?B?WVR5bE85dnFkemVqdjArUGZFcy9NdW4za0M4QUJjWUVTZlVaYTAyZk9vWlhv?=
 =?utf-8?B?QUtiUWNIYTJ6dmNqUEt1SDZlSjkxeVgwd1cybEh0eWJRZWpzSEdkQStFNGwy?=
 =?utf-8?B?WnpBYUZjNlRTelQ5Q0d3ZFVBdnkwM2dGT1dxN2xEOGxmT1QwZTVvTjBWeEpR?=
 =?utf-8?B?a09QVE9kTGwyRmczL29ha3dCZStaMGE5amsrbUlLSFF5dXpzdWk0NkRrTDFq?=
 =?utf-8?B?RjlBTlJteUdvR0ZEUy9jOTg5bFFTMDkwR05tL21FRXhlM2ZlZ254UFBRK3ZQ?=
 =?utf-8?B?YmppQ3BLWS9VazRSNUF3UE0rK2ZKMTZ0YnYwTmdaVVFBUWcwRjgxL0s1RTZM?=
 =?utf-8?B?Yk05b2k0V2VpZ2dxcGxtOEdVQ3NIMUJIS3FaY2RGaks0VnowbGtncW9ET1Zo?=
 =?utf-8?B?c1N6Y2Y4L29JVjZBZDNXZnBKSEgxbURMTzdkeExEUEN2bTBVckpxUnU4S0lZ?=
 =?utf-8?B?QVp2VjJKTDFmeXI3c3RsMWt3cm9nK0lBeXZ2bFZ2dGJPZE1vdHZuSTBaSXY0?=
 =?utf-8?B?K0IyUEJQVzJ5UDdoN0p1b09TRit4LzYzTlo5WGVtMG1xNzNDOVlGRjhHNEc3?=
 =?utf-8?B?TkpWcGN4YWYydGU0VStKUm1Eb1RiZkt2eXlZNXZ3Vno4K2hoQ3E4NHIycGc5?=
 =?utf-8?B?WHR2Z0tMWk5ZMEdFOWNzMzlGWnY2cTllNkMrdVBKWUpHb0QxclF5MWhaQm8v?=
 =?utf-8?B?S2JkVkRmL2ZSM0JzOXdESHJQTHltT1A5MGYvbVZTbmRlajUyVnNRMEZFK0ps?=
 =?utf-8?B?dmdnU0xOdUc1bHVxbC9LMExLcHVZcW1QU1k4ankxWEEwRm9ZWHVkUldZUXZV?=
 =?utf-8?B?RktzM0t4TnZ3emtjSTFPeWVHNGRxcnRoZ3FSUTc5QWJSaHliK1JFVW8vZWl6?=
 =?utf-8?B?eVdPS2VrNzB5MEwzWUlOYkg2SWtjdVRkUzZWSUV0Umg0VG1UazZobUdodXMv?=
 =?utf-8?B?SENTK1ZqUmFrb1BHNUZFdzVhSzU3dEtIUXVGOHNLaFJ0UHU0cytLY0ZiT0Nm?=
 =?utf-8?B?cU1ldUZxTEJ3QzM4V2RrQTBnNWxhcDVUMTg0ejBtdG14ekQ4d2RoSWR3WFpl?=
 =?utf-8?B?cTJDRk5VVEY3NXBVVmYwWG1oYkcxZnh5cDNvSUJxdEtSQkRkV0RvQmdiQU1G?=
 =?utf-8?B?d2NSSkZQVWxMdkFhREgyOVBnQ0o0dnVZL3BEdHJKNVRueERSVUMybnJXcFBx?=
 =?utf-8?B?bkV1cFBmSUJYam93dlU0ZDFhZSs4dlh0R2RlUWFSM2xLUzUxcDR5WXhCN281?=
 =?utf-8?B?c0dqWWkzajIyK3E2NTAycGVKOHlOczFGd1Nxd0hsaHVSMlVHa2pyd1VLYnVs?=
 =?utf-8?B?eVBESEJGaFRCWlVESHZBd3d2TFdKcUR1UUQ3TTZMSi9ZL1ZGNHFJY2Nyc3JX?=
 =?utf-8?B?UE00R29URTJzV1IxeVBHZ3ZPMWd2aTB3MVNmSzlKcXMwanNIWm5jTUJFK2RT?=
 =?utf-8?B?Q1J4ZCt1TEpGYm1oV29MTCtJY0NzNDI5M0Z4MUZvb1N6YlVUL2pqL21HSVcw?=
 =?utf-8?B?Tk5qVU1nVlVYcGU4eTVqUkJFaENZVHVkNVFMbHAvQkM0aUt6UjlDUzZWNGVy?=
 =?utf-8?B?K3NFMVFuSHpkd2Y4WXc4UHFiVWJLR0c2MEVkbWxIUGJKdCtRT09RWHVORVU4?=
 =?utf-8?B?TW50Nnpjb0dBMWVsTS9EZnBRR1IzS2JKNG91VC9lVUNjS1Yza0RFblVKWmNq?=
 =?utf-8?B?YnRIWmwzU3ROVENhaTFIem5nb0xuWkJtNG5IK1ZuYWVWemgvWGlncjgzeVJK?=
 =?utf-8?B?TWtFWjRiN1NEd0lZcFB4QzA5c0t3N0hJczUrSFRCS2kvS2dTcmlma3JHNitJ?=
 =?utf-8?B?RzhKZUJyY0xDWkszRUh2QnAwYk50QUg2a21FbXBnMGk1QmFQcjA5eFV6a0RN?=
 =?utf-8?B?b2JaOW9FM1RSbGpqSFpBOG9zNDBRdWUxYi91SnJPdGs1L29FMEdDSndFbzMw?=
 =?utf-8?B?eCtXSGM3VFdWMExkcWJMOWd1eWREMGpQWE55RDFNVS9UYnJ5Rzh6aTBLOHNi?=
 =?utf-8?B?TUhWRm1uLy82eHZtVG8zUE5IbkNEWlFVNHJFTitxVDJTbHR0bDBaNjIzZFNP?=
 =?utf-8?B?MG1YRmFJcXJGcnRzWFlaOUJMdnV6aitBSjc2YmZaUjZ6RjRuS1EwL3F3ZnRJ?=
 =?utf-8?B?Y1FKS2d5Vk01TFdrRFAxZ2o2WHVLV3pjQnhxYmMwRWNzL2tGRWh5VnNwbFQr?=
 =?utf-8?Q?f3yZVSVOOAtzL0OgBapOxbhWTNMubW7zqyYY4P08uW88W?=
X-MS-Exchange-AntiSpam-MessageData-1: IJ9BQ9+KCyO4VA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a15c13-5cfa-4cf8-89ef-08dea074d7c6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:41:23.1530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsRa02NyrSGg7Yyq78+DVwq255FFiDME7MbJF2iCiF05a7UcDUtfutAMju2UC5JDUX5QyXeQBqhHifDquplwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
memory region to store the GSP firmware, and the Booter Loader loads and
starts that firmware into the GSP, making it run in RISC-V mode.

These operations need to be reverted upon unloading, particularly the
WPR2 secure region creation, as its presence prevents the driver from
subsequently probing.

Thus, load and run the Booter Unloader and FWSEC-SB firmwares at unbind
time to put the GPU into a state where it can be probed again.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs |  1 -
 drivers/gpu/nova-core/firmware/fwsec.rs  |  1 -
 drivers/gpu/nova-core/gpu.rs             |  8 ++++-
 drivers/gpu/nova-core/gsp/boot.rs        | 53 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs            |  5 +++
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index de2a4536b532..771b018ba580 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -280,7 +280,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
 #[derive(Copy, Clone, Debug, PartialEq)]
 pub(crate) enum BooterKind {
     Loader,
-    #[expect(unused)]
     Unloader,
 }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 8810cb49db67..4108f28cd338 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
     /// image into it.
     Frts { frts_addr: u64, frts_size: u64 },
     /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
-    #[expect(dead_code)]
     Sb,
 }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8f2ae9e8a519..37d0e4587ed3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -286,7 +286,13 @@ pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
             return;
         };
 
-        let _ = kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.gsp_falcon));
+        let _ = kernel::warn_on_err!(self.gsp.unload(
+            dev,
+            bar,
+            self.spec.chipset,
+            &self.gsp_falcon,
+            &self.sec2_falcon,
+        ));
 
         self.sysmem_flush.unregister(bar);
     }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index cd11df319640..a35ef4481f55 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -268,7 +268,9 @@ pub(crate) fn unload(
         &self,
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
+        chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
+        sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         // Shut down the GSP.
 
@@ -280,6 +282,57 @@ pub(crate) fn unload(
         )
         .inspect_err(|e| dev_err!(dev, "unload guest driver failed: {:?}\n", e))?;
 
+        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
+
+        let bios = Vbios::new(dev, bar)?;
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, &bios, FwsecCommand::Sb)?;
+
+        if chipset.needs_fwsec_bootloader() {
+            let fwsec_sb_bl = FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?;
+            // Load and run the bootloader, which will load FWSEC-SB and run it.
+            fwsec_sb_bl.run(dev, gsp_falcon, bar)?;
+        } else {
+            // Load and run FWSEC-SB directly.
+            fwsec_sb.run(dev, gsp_falcon, bar)?;
+        }
+
+        // Remove WPR2 region if set.
+
+        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+        if wpr2_hi.is_wpr2_set() {
+            let booter_unloader = BooterFirmware::new(
+                dev,
+                BooterKind::Unloader,
+                chipset,
+                FIRMWARE_VERSION,
+                sec2_falcon,
+                bar,
+            )?;
+
+            sec2_falcon.reset(bar)?;
+            sec2_falcon.load(dev, bar, &booter_unloader)?;
+
+            // Sentinel value to confirm that Booter Unloader has run.
+            const MAILBOX_SENTINEL: u32 = 0xff;
+            let (mbox0, _) = sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), None)?;
+            if mbox0 != 0 {
+                dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
+                return Err(EINVAL);
+            }
+
+            // Confirm that the WPR2 region has been removed.
+            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+            if wpr2_hi.is_wpr2_set() {
+                dev_err!(
+                    dev,
+                    "WPR2 region still set after Booter Unloader returned\n"
+                );
+                return Err(EBUSY);
+            }
+        }
+
+        dev_info!(dev, "successfully unloaded\n");
+
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 2f171a4ff9ba..21ff5d15f648 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -176,6 +176,11 @@ impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     pub(crate) fn higher_bound(self) -> u64 {
         u64::from(self.hi_val()) << 12
     }
+
+    /// Returns whether the WPR2 region is currently set.
+    pub(crate) fn is_wpr2_set(self) -> bool {
+        self.hi_val() != 0
+    }
 }
 
 // PGSP

-- 
2.53.0

