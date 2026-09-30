Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A9CCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCC710F430;
	Wed, 30 Sep 2026 14:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VuSeBQsZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C94610F430
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY7h/GJLcjmxrjAhChuMK0qlJiv0dMnGSkHPOqwpBbmZYljRowcHeE8OMhxY96UT/u842kF2WaGIWFkMCxwUFnpXWMEmtoXmJAH+rdQtgyhnYb27I7vP/3J0OA0vEym+/r94n4VPwdeWD53utyGYUwn2y6VUxgqgiNZxbDpBmCrtXNKjfo817o1scNQmc/JuiSEoWI3LhYsueoXR2O8a4wrrX+W/eyiJ9ZOTYitFCF0ntwGmk2IUJWxMuzSLm7jNw3uGVemchRYpzRN5T2tSvXyY2RpPcTKMMoQUm94a9RshY9fM/+CyqVRsmmT/5tkP9q2welpnQzrVHK5wBJ1y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuTEpWN/vabtUmTCDn1mxpo7b+rVOOThLEY0jUQ+ep4=;
 b=KkymAjujcvVWiKhAAyBzarG5FyIZUcRqjKpjmPQL73ufmRI2iNwDbWl1dPvDfsf8VpC4s1Q0g1oqO58p64KzCMoHMr39KG96K9iOSAIyzPzTpTD4kGUiqEHaSwHENzECXo+sv2QjQ3/8FNqrxoAxGf1jx6yfpYr4kXl3wC05dfYZb/M+atoUQGHujoxRFDqO5KC8YvyCb32Gm9YQJ5vNdgXbn/MSM0B2kCFxiozjqKIUtTMCp68gz7NRSrUvs2YWMmQDBxwroD34eErGAWf7+rimifgV3/0Vh9K5SpXGMv/bzpRTVBZbs3QebE9mI23D2WrbIyaPbWJw7jJqZZfMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuTEpWN/vabtUmTCDn1mxpo7b+rVOOThLEY0jUQ+ep4=;
 b=VuSeBQsZ+c0fxzeMLpTL/TaQANyDiyLbZp5/mGuuR5d8SyTvGbCGXYXH+rUdWqjuFDYZq7kYcnXYLW3w7lJsh92P7PMMXqT+3gODkDRVjYN3kl6Dj9/uvyWEcO4AoC2V36c8ae+/TjLMrWxFK6koZLdun9ifx3F4X7dHM5Dx3ziupYMJogg4fP5MTcNKndEcM5Ag24xx4af0uIjgAywFpI5OohEv/tRwtyvLcx0QcQXjPN/ncioGJD3+3HbPVJ+EHIU/q/J26JdquIGjDfXEo98lNvP0fTa5+924SAuVmD/d5JKPNwOGAIp8Xf2zuxpiPgLemfAmGr4itiJP8HTcjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:10 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:44 +0900
Subject: [PATCH v3 5/9] gpu: nova-core: gsp: cmdq: split RPC parsing part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-5-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: fe446631-ed2c-44eb-228c-08df1f031aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YI1osNDNy/FVrlnq0IvQiGoBIcnDAxQ8syCmHyw9wlA/B4fZIrscrNdKdAZXj7XCMBQ57pTQSABacF62UnfUxYcqXziOHyNR0pqpUAyORF4nQBm2q2oC1aWxGuKo3urPX679U+v/sryaGZXHQb59M7ndsw5PKkqgzLT3ILzcTTTfvdX0U0P/mZwHfAHP+GLnDwEdefaNwEIdW1dp98Eh59Y7w37eXmhHeXIM18AFcmD7GSQ8EtB4SnPwCJVKwFiTiVIsF/oheHrisdX2nRPp1GFtjbOpV94a9a6Zc4BNn1dthmRlRA1wyoQRrbRSkalWYSb0GoiRRO7RPoRU5xp2ljzwGBTT6DbXYwGJjmWpSghVN53YO3dsjxamgbyAYf3WMrD3ZL8c5zof9mGF10yqn/PcyAD4O0IWhaAVeyHzqgC4KRDoamyeG2akUMOF29xwplqG0c3i+Tzlrs7yI8RGeoUfsLlU7m6/88Xc54Zaxk9VCuyWwVQn9NjpsQ6JD1mAFZ03hkT7DXWcRqAMyh8vJLkNXa6+nh0KwP5YzgZJ6qhF0thLAvuE/E61tCzYNhlyR/y4eJuJkDLMAxUF7jBiYTVRoL/g6/lOBxfMic03w6dJeqqT8A7t1tXOo+QQmdFoi3Nbuua0MpeuDHh2gquhTjwQTvyaQ+xaek4Wb33hgAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3pYN2ZNRFZOR2lZOWlqT05hT2J6N0JETkl0d0NRM2JoR1RrQXlLenNzOVVB?=
 =?utf-8?B?d3RkVVdKRFRFNCtJZWxZbjh4TDEvd25MMmVaZXBpalB2Z1JEYXhkZ040NHEz?=
 =?utf-8?B?bzIyVGYzZ04wRFpoOXBNTEdrU0Y2OXY1bWg4MDN5YnFZRXFNeUI2WEhLaG1L?=
 =?utf-8?B?UGdBYkxjaHNFZHJOYjJMN3NFUmlFSkRuK3YwMVlScUtCczVZaTJMSUVDNys2?=
 =?utf-8?B?akg5V1lDb1NjN1BscjJ5dU0zbzBzM0RLZHB3cVo5dXd1RXJ0L1FvbnRMV0N3?=
 =?utf-8?B?ZjI5Mi9sK2Vxdm5iOXd0bzFlSzJlZGM3MzlFcWtudVRoM1hyVXNQMzUrbW9N?=
 =?utf-8?B?Rm1DMDZySVFBU0w2YWlBTGNSTnorTlhNRndSVndhNG5ZZFdZTUQ2WEFITFBY?=
 =?utf-8?B?Yy9yRmRseXRlcnQ4YWM3cmdGVnVHSFVmT1hsdHF2dStJb21JWUpJNndtSzJZ?=
 =?utf-8?B?dkd6cGJwSmhkQlhQMmdPKyt5TWVJWmk3ck41RUJrRTBzVXlPc0l4NFBVSlh5?=
 =?utf-8?B?R1BqTVUxbzB2K09zOEE1anBtd0kra29keVhUM0JWNEVPYU1ZUzdXY2I0a1Fk?=
 =?utf-8?B?SzRHYXBicTJiTVdWYWFCbHUyYm93aWZDTUh0cDBpMExxSW1FVGNDQXZsTDhQ?=
 =?utf-8?B?NFQ4emJYck5mR3NBUHp4eHRhbVd1MzljMjdiVEdqVDhVZXh0L2lQRTdLcU56?=
 =?utf-8?B?anFpZ01ObFpTcTVodHd3cy9ka3JDMGJHWXRabTE0d3JKREhmWlM1Q0dwWmFa?=
 =?utf-8?B?UzJxUHpWZG8vWGRGcUZiRi94d3ZuY0dWWGlFOU9XcGlJVERvdUZhbFFOdVla?=
 =?utf-8?B?UVVRWmg2U053K05abGRpOExjd2pMTGtFcTdpSlJid0ozTGkxS1NIZkxZUFNw?=
 =?utf-8?B?SGF5bURFMi9McEFrNXJjckJkN1dHQkJ3NWJzeGZmdnhCVXQzaHhCaGJJMnY3?=
 =?utf-8?B?S1lRY0V3R3NQclRRVjNjZDNtTUVPY1gzYzU4S0dSQmkzMGdNMEsxTElzbkov?=
 =?utf-8?B?RnAycjNnMHZKaHFHVFhEV1ZTZFRiUzlrOGllZGlRb2JJNHFkbDRvSlBnOHo1?=
 =?utf-8?B?ajViSU5LbElDZ2tIZEkrSGluT09lUkJUWVhNUmVxSEFSZmUzcE9DT3pQV1g1?=
 =?utf-8?B?T0RHd2I0VlNBWVkvUmR3OWVYQVl6MGVqRFhIbFJyYnpNWU1KZkwrellRTy9B?=
 =?utf-8?B?ME9CUVNoWklrM2RNSmNLMzlXMEtYYTgvZ2psQWNKQjRrUUNmN0c0TDRsUlV0?=
 =?utf-8?B?cE9vQ0dXVWx5ald2Qmh3Q1JOVjl3TURKd3Bsb0czM0ZrTFI4M0NHNEpHeTIz?=
 =?utf-8?B?MWZKSS9RWjFBeVBMZmZBRlVWdjZqUTJQcXJGNG50Zncyd2g3Vy9yTWpNRERM?=
 =?utf-8?B?V3FndHdjTVVwY0JIZVUwSVI4Smx3cnpXQUVOK3BGUWdmNnp5QXNZM1QwZEJ5?=
 =?utf-8?B?MldCV2RkNS9BZVZYRkpwdTBNMlVWRlNnaXVXcURmcTVqRGlnQXdjYldhQUpo?=
 =?utf-8?B?Nk1YZ0ozWUdnKzkzd1gzTU5hVENjNi9DMzJSdXhnK2VXOEh0Z2NEVjZKSUor?=
 =?utf-8?B?dlRUNHhtbFFEdm4rN05OdXRzalgyU1V5Nmtrbks5ZXI2OFZqeitmcjNhRWM0?=
 =?utf-8?B?VzZaaTl1Qml4Zit6NXU5ckkyRmZUQ0NWcC9zRlkrNlRLRzhRL01uSE9aVW9N?=
 =?utf-8?B?Qzh2V2Z1VHdGWUNHbnYyM0hsbTljeFptbno4VmMwMGVRVjB2S3Z5QTZCdktQ?=
 =?utf-8?B?bjV5TXNsUDAxV3VZZDFxOU9xM25qOXlwc09qS0wxbzdCUnNlN3c1MUtja3Rp?=
 =?utf-8?B?TWYvZTd3VmlSMXhwU1dkSzkyeitUUkdoeVhRV0NJNlBFdGRCYjNEZ2JVS2ty?=
 =?utf-8?B?OUUrbWFDR0Z3aVV5c0FCT1hjZDZQUitHWHp0bHJ3M2lzUmZ3cTdkUVRYYlVM?=
 =?utf-8?B?M2NFWnFibVVVL01SakhJcGJ2N0FBSHpCeXJ6NFUzUkJ3WktGbzUxMzNRUzBY?=
 =?utf-8?B?SXBPcjhBVnhRazJmc2xBbklIekc5ajlvRlNHdVdRam1adnc1SjBaVjVRaFU2?=
 =?utf-8?B?MlUrK2dURk4wWnZpQldNcDVVTWI4NytkS3U5cXlyNkprWGNyajlYL2h5WFRQ?=
 =?utf-8?B?aG13QjVHZVNSVDdscHM0bDVFV0ZBL05EOStUQU1naEsza1JaZGorV3N5UDBi?=
 =?utf-8?B?aVhXeWF4SVY5KzAvY09MQnBhcWdmZzlxUi9FWUtiMGxndmk3YzJDK0xnV3Zw?=
 =?utf-8?B?QWRZR1MyZEZLUjNhdkR6bTlRdzRvelBzMHZXSThoR1VLUVRyUnNLMVpTdk5l?=
 =?utf-8?B?dXJFMjg4YXJKM0NZSXZHR2R1Q1BoZVBDTTRmMnJuSFRPVmdhNHoxNEpEUGQv?=
 =?utf-8?Q?w+cT6GitAz6rETABlZ75p/B97X/LDv2SqtBAycPrSzQLQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 2MBKvnPnHesGcQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe446631-ed2c-44eb-228c-08df1f031aa9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:10.4142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8kXAGi2Lyvz0/Un/w4Cq+aO1iw9gDQX+K8GyVW5Nr9gFo7m+n/yKlpUgzL2mZ9E1jNUopgjF+6SolgVFygwzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

The RPC parsing should not be done in the same method as the transport
header parsing. Split it out and introduce a `RpcMessage` type to
indicate messages that have been successfully parsed as RPC. This makes
the code easier to move around into its new destination.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d8a7716fc500..b8a9e02b76fe 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -553,6 +553,17 @@ struct GspMessage<'a> {
     contents: (&'a [u8], &'a [u8]),
 }
 
+/// A RPC message ready to be processed from the message queue.
+///
+/// This is the type returned by [`CmdqInner::parse_rpc_message`].
+struct RpcMessage<'a> {
+    // Reference to the RPC header of the message.
+    header: &'a RpcMessageHeader,
+    // Slices to the contents of the message. The second slice is zero unless the message loops
+    // over the message queue.
+    contents: (&'a [u8], &'a [u8]),
+}
+
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -794,7 +805,7 @@ fn send_command<M>(&mut self, command: M) -> Result
     ///   message queue.
     ///
     /// Error codes returned by the message constructor are propagated as-is.
-    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
+    fn wait_for_msg(&self, timeout: Delta) -> Result<RpcMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(
             || Ok(self.gsp_mem.driver_read_area()),
@@ -816,6 +827,24 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
+        self.parse_rpc_message(GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        })
+    }
+
+    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
+    /// to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    fn parse_rpc_message<'a>(&self, element: GspMessage<'a>) -> Result<RpcMessage<'a>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = element;
+
         let rpc_header = header.rpc_header();
         let payload_length = rpc_header.length();
 
@@ -845,8 +874,8 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             )
         };
 
-        Ok(GspMessage {
-            header,
+        Ok(RpcMessage {
+            header: rpc_header,
             contents: (slice_1, slice_2),
         })
     }
@@ -873,7 +902,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
+        let function = message.header.function().map_err(|_| EINVAL)?;
 
         // Extract the message. Store the result as we want to advance the read pointer even in
         // case of failure.

-- 
2.55.0

