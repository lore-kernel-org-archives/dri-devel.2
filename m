Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97607F436B8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1278810EA7F;
	Fri, 17 Apr 2026 15:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vh45ZKsx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A3D10EA7F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUnvXSzgD8OyPZE8S2ljGKJunFod3gvRDZeNjRut+T4Y1O5wMIafQV/xgSoQhVuLIYQzOnDY9OfigVS+gtK4NCzmSLIgSE6Dvkw/aLVbHx8v+r8Ytir8bjwqoYNZtzhjm4EryjcPJElSlttZ79OoK44jdCfdJ85iy9nZ77UKYjkuBQ4Z14qBs/43L3m/b2xkbGQomk1uzfC9mB4rfDnYJlt7+GzSRhUVC3DlTDUM0Lyp+e7Zj8zHspnBq5EeoXr1d3if+5yr0C0gAZi1hcnXXbrJYOxjo7XWrLV+I2Hvm4cx7PNXPF7QrUFnOa8sI4OQcWYTIggATKFwEmHkEmZBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL8APXnDlLX95vpD9YtCmQFLBfTezkb/NWK05oABTko=;
 b=ujwF2CZPyrRKAZu5VPYNSJkA4ygiV7N5d0huksIQvUfxX/UIsltd/W6lHNH30KhTYTSDnkc3YKLw3kHRGSH+aV1e6m3rFsO29Jz+tbnPrF2BMcRIjYuWtXWoZ3/p85U0UmgibwhgleFE+3OnECHeD6U+4HKX6BALxvpt2X/kVQLD2k8ZkbJquZffO/76HCNDPbcQvrFGPuvXEYJxfmGfDcFB6Q05w0dsfialcfFXrmVJUF6KbbqBmlHJRBRWlrCDFidaetCNttRYj52nL8qdu02o0C9G4uxXrIxiZuoAItAUDUoJN98MVbA53+6bJvFtUDjJHJSDGFycZ2Y81kFtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL8APXnDlLX95vpD9YtCmQFLBfTezkb/NWK05oABTko=;
 b=Vh45ZKsxiLpL/XseFkZi1EH6WEoLjEqUi2UaS7EmEDUOzwFrYc4zZhPOhX2GVgpYcgZrsTR2WcBYi2dYMRA/SRRLlKg+sUc0whUmtJF/rit72AhMg5zvDUoEo+1RSAwsqJrjt+yNGdBCwJd4A4NFpE22HBQprlZKNUZXV0h4BU0hqFeV/4i0El9md4+IfxQvIp67ihBbj4TT4bVv8JrWO3WUjSRVuUb4SRx1Rkzm7DI9dDstfGShkKBrcu6AHAQ14tIHwvI0Kkuvz3NGo9x9xpMaJCK/MdB/xDsd4kjSknazuV37K3qDOnHF9oQu7Kj2SSeBiEu/09mPA/JtDhvwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:25 +0900
Subject: [PATCH v4 7/8] gpu: nova-core: use KVVec for SBufferIter flush
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-7-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DS7PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: f63fd262-eafd-48f1-a1c0-08de9c96be06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LNfCyqJ0wRCTbnz9StWbT6I3bQmHRCQRkY9hY/SHbqoAMx/48KhI9F99WsWHL8XiRoKxEXj9B5p5qww7l0N7JTFn51inl/xnQC+PnHmXyFV9ODVdMXyQYabKzmy11doFFX/NlhkeIC2vfdOnR1/qAjatSZ9O7cBS0nNO9F7h3lJX3c3crb4IyfMInD6DgLNI3ZS6XkyVYBNX2gfA9DUqyGqpIjSj6YTVA9mWt3cXL7Ogpob3i/lz2Fbr4e387O89Yl8x9yANDM5iJm5gS0YuUkjY7rZin1NQKulOPZJRblffm/hGc+b4czxZqMiW6K8R9Wf8cD4QNw39fWCMVxyBO3IAijHVUIPDhIrbY4YT/DrjH4T5yln+/1FkXC78uZxffcdQXz9l0axoDUCwifNNH5LT2J+B6I0/W9wGXpXyQoBJVy1G2Uv0/0CZ1kQcVa+jD969agIwSsZRmzpBHRgBQRboBRv4Y0iOWvsPyUrYTP0fm4Jm7a6+7fan/uTcht7KWzgYKBpbhG9pgLEudqncnAfQL8MUJwuNlzrN5W5lPTCsn8gId/9kivmpaefRXL4t+HjYd07mxoQ9YJBL9Vx31VS3AVmeM+gCK7IHUouXXbLXCmhGnCCjWp1jZXcBrkwRe4wWJ2JlP8w0QoUEDra90aWIQTjUA0wMWPONGGE8SGDSYXMqdjNDjRyP/nQHDnrgfmhh4eVaRpd9uSrMTPcdE2zTCvZguz4+KxcYEDd8YX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2M3WUhXQlA3ZDJnTGtyMEFTWmgrS1psMGphUmswM0FscWgvbHNkcVpCU0Zk?=
 =?utf-8?B?Q1RDR2M3M0JkRjZiWVhXOVNyQmNtOEsxU2xNRTJDZ2Y0WGhMRGk2VEd4bytM?=
 =?utf-8?B?L094YUJUbkpnYldBUktwUGl5YmxDMmxOS055RDFyYzhnTzZMdUhlWG9KMkMy?=
 =?utf-8?B?TXkybEhYM0o4RXhiZUJDRlY3ZFQ0VG1ZekNqNU5XMUZRcUgzQldUd2d1dkJM?=
 =?utf-8?B?Uml5SmN3ZTJmek9Wdk5WQTFBK3BobmlTN3Nvbnc4RXIvWmRxNE16MkJQSW1G?=
 =?utf-8?B?SlE3Q1ExV0pPSytGaDMyRzhDRHNHT3VBSEJLZENFQzhlaFlNd1RlV3c3dXZY?=
 =?utf-8?B?R0c5azIyWExhV2Fqd1pwVHRxNHhtNDh5NWwyZlY0d1hiaUl0b3crK1I1dy9O?=
 =?utf-8?B?MXl5N0pKTEtGYzErTkU0MWpzMnVxUjdrNlZLM25mK2hObjR5VUd6MVc1aXRK?=
 =?utf-8?B?MWptbEloWkk2TEVJNlo4RVNyV2IxRW45WGxGTTNvaVpXUlRrREhDUXo1WURz?=
 =?utf-8?B?T3A4Zk5sWHdXb000OW9IVndDQ3krOGJBWUlISjNWUDVxNmI3c0lLc1VWalB5?=
 =?utf-8?B?NHZwV2k4bjVIVmxLaWxyUHI0TnQ4VUYwMVB2bGV5SzBCazlRUVd6NXc5NG84?=
 =?utf-8?B?UkRnNHMvUTBXK0FaWUliU2FIOThFZmFuR2JTaE5CN1pUZk9NTDg4ODBmcFhz?=
 =?utf-8?B?cHNlNWtTanh0R0tLa3czSUlaYVNodFNHaHpBVGZGTlBCR0NoOW1nV2xyV2d4?=
 =?utf-8?B?UGFsSHRFMGwzd0dkQjNBalNZUDc5c2ZOU3hhZWJMKzRRYk1yUUxSSmVSbzVJ?=
 =?utf-8?B?aHBnRHoxcEFUSUtiaHVDdFlrYTNwTGhvcEZKaThvbDcvOXB4WlVwUUp0VnBs?=
 =?utf-8?B?MEZocENZbG1BMjkyRHlLWjg5Lzk2OFduelh5aEJwOUhTTHMzNWk4OXpJWDc0?=
 =?utf-8?B?VnpnOHYybU9NUWgrbnVNOVA3N0g0dXo1SEVEdWdPMU15VnBkWmpEZ3pDaWhJ?=
 =?utf-8?B?NTVISDJPYzkrOEhOclFCTFphWHZKRlRUdm83WGhwZ1lTQlZycFZxNW1nT21Z?=
 =?utf-8?B?aVZGUHhNZW50Z05SZDI0S29pQ0Vvek1sdTNjODBuelhRSUptbFpVbENRSFRk?=
 =?utf-8?B?YU92K1Z3Tmx3QVlGZ1Z0QmUwRUdlNG1Oemc5aklDWm1xUHNzM3JObVFMbWYw?=
 =?utf-8?B?VUc5QkdWVmRoRmx0YlpwNHAranFhMXNiWlVUVlViY2VodGpFRVpjL1VibTgx?=
 =?utf-8?B?RzJFdG5HczI3blMvejJXVG5LdHQ4eWVxKzA5MGVQQ1hqeTh2TEdZTk9vTnly?=
 =?utf-8?B?ZTJOb1Y1c2tsL1Jmb1U5aExnWUFZNHFJYWE3SXVJNUhhTmVnK1F4SnNENEdz?=
 =?utf-8?B?Y284aXBENnlCdm81d0JXN3pYdW5nUk5kV1FkTGVTZlFGa0FtZzFZMjhlVi8z?=
 =?utf-8?B?Q2dLR21yYXJTM0dwaUhCQjdLMW9zamw5OTJiQ1l5Z3RNZmVXd1BDM1VndFB2?=
 =?utf-8?B?Si9rVVBjWTZIVlYrOUtoTGF2Q3BQQmJKM1YzK1dpRENUVFZZZVBNNEdEY1Ra?=
 =?utf-8?B?eG1FVmw3bnI3RFM4WDZQMlN5eXoxV251eW9SNDFmU2FjamdOUTBmcTRBcXFQ?=
 =?utf-8?B?VytJbUZLS2l1em9yQjZ5ellpQ3J1TVk2QzV4WEkySlVMUVFsYlpJUUZ5SW1l?=
 =?utf-8?B?QUxoNVY1M2ZydzdRSHZ4cGxqODI5Q0UxdmdLREMrc3dweTgzdzdSZmxYMXBh?=
 =?utf-8?B?WTdkWXIvRUN3SzQrZXpYWDNzWDU4aHY0OTJPL2c2TUM2dE1DUUdXNTZrRkN5?=
 =?utf-8?B?SEhSMm9ma2phZERVY0VWWG5sSGh0dHh5NER1R1JZNVBrTkEwRkhqS1JjNmow?=
 =?utf-8?B?V1R4VU8xWWVpVkYrRkROVEkzeVIrY1hZV1BSZlA5RUF0Q3JOT0c3VG5GMW1W?=
 =?utf-8?B?QUF3N1h5aUVYNnZvdDRqVmM2T3AvSjhRa2gyUHN5S25VSEFyam1neTVXZjFu?=
 =?utf-8?B?di9NbEVFY01kYWVyL3lxRWFpWXE5RFZkNW0zY3RxVmZSSDZSeXo3M0JiK0ZW?=
 =?utf-8?B?bDFoekZwYTI5Q2NzRkN6aFFQa2l5TWdKZVdqUWpLa0hvYTlHa21oS2VHNW1D?=
 =?utf-8?B?RWRDdGgwUzJ1cmY0VCtkWEx6djYvZjZ4NDUvdEdlU2szUS95Tit0WWVJZTh3?=
 =?utf-8?B?T2FIWWl6NnYvQTZWY0h3bHJjZTRmV09MdFBYQzZnMGlQdmVUdzlGclFoSncv?=
 =?utf-8?B?NUtLQjVoRkxqVVNTREJsbWQyZWs5WWxJVmVSNXlJaWpPdENrbEpGMUdXZVRw?=
 =?utf-8?B?TVZnUHZBOURybEpNN1c4ZmlrVE9iM3F6bUVtMi9MMFJPamxPYi8wZlZ0MStB?=
 =?utf-8?Q?PzW+moyzs4VvDjA8VqGAcAJXx5lLFal+PrfAUrKdc279E?=
X-MS-Exchange-AntiSpam-MessageData-1: naHR1pWucYVcdA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63fd262-eafd-48f1-a1c0-08de9c96be06
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:58.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGh/14xkWErIv4k10+VWI6aod1aB9paNJ1PhRwi39NZoHWen2vMYfWeemi24qJqUYtilqReAdo58JtAHILaYxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Change flush_into_kvec to return KVVec instead of KVec. KVVec uses
vmalloc for large allocations, which is appropriate since RPC reply
payloads can be large (>=20 KiB).

Update GspSequence to use KVVec accordingly.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/sequencer.rs | 4 ++--
 drivers/gpu/nova-core/sbuffer.rs       | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 672c7d6c3cf6..62aab20ce8c6 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -43,7 +43,7 @@ struct GspSequence {
     /// Current command index for error reporting.
     cmd_index: u32,
     /// Command data buffer containing the sequence of commands.
-    cmd_data: KVec<u8>,
+    cmd_data: KVVec<u8>,
 }
 
 impl MessageFromGsp for GspSequence {
@@ -55,7 +55,7 @@ fn read(
         msg: &Self::Message,
         sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
-        let cmd_data = sbuffer.flush_into_kvec(GFP_KERNEL)?;
+        let cmd_data = sbuffer.read_to_vec(GFP_KERNEL)?;
         Ok(GspSequence {
             cmd_index: msg.cmd_index(),
             cmd_data,
diff --git a/drivers/gpu/nova-core/sbuffer.rs b/drivers/gpu/nova-core/sbuffer.rs
index 3a41d224c77a..ae2facdcbdd4 100644
--- a/drivers/gpu/nova-core/sbuffer.rs
+++ b/drivers/gpu/nova-core/sbuffer.rs
@@ -162,11 +162,11 @@ pub(crate) fn read_exact(&mut self, mut dst: &mut [u8]) -> Result {
         Ok(())
     }
 
-    /// Read all the remaining data into a [`KVec`].
+    /// Read all the remaining data into a [`KVVec`].
     ///
     /// `self` will be empty after this operation.
-    pub(crate) fn flush_into_kvec(&mut self, flags: kernel::alloc::Flags) -> Result<KVec<u8>> {
-        let mut buf = KVec::<u8>::new();
+    pub(crate) fn read_to_vec(&mut self, flags: kernel::alloc::Flags) -> Result<KVVec<u8>> {
+        let mut buf = KVVec::<u8>::new();
 
         if let Some(slice) = core::mem::take(&mut self.cur_slice) {
             buf.extend_from_slice(slice, flags)?;

-- 
2.53.0

