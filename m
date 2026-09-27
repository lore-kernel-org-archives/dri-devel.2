Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDCDC9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296F988867;
	Sun, 27 Sep 2026 13:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BKUyS3MV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F4810E204
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsfNr0KJ+XWixMpDQg8JgCoVjVRw/hs0VnVDuOdOm5l2fKSTkTEJUeCei+64spwvDB2al+UDSdgHqyGlraUBTN4T7OLZC/N6/fk5JSr/cTfL4+n5EwPk/BHd34UJx2dl+z3RleFI3nR1tWVWug7f3NIviulQhxIevlRMxixJ3higleU/+ykE8x42FpZJY5d8rhryx5Sid1fbflVqnO4vVV6SgtB2KGv8ZGi+8tUWJ6zieQ6PoVqDrlgOyIBAOjifJ0eGhsKk1/iCuv+Flt3ZvjAQLjTvcE6HADxFbx0rhQU/mSy6WKDdhWlR5SUJJyxE/YC1aKOG7t1Zo7HAZaYH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGjFLwUnTEe1bJDzk4SnMPpEOFqWrTRkwNcKHjoJAXs=;
 b=EosuD4HRkHP5Zz1Pa0KTUHOfuHtuoL8v1ZfqnhplC7U65byXRsuNpCE4tN++Dd66IjzgJk1yh889bgt61YyzGv/DBlhFVzBLZ8tqWYhsKZDFo9UqBIxsvlf9gOqRYG+Iw3qkEeoUPVjz3bJkylBaMLRsfYmeZF3YKaPBTJKWI/nCFedITIFUlBmzsKIYftx/F+kiMwU89Vb0xPxSK7EXv6UGEokjr+jW4lt7eILr1sD5NwEzW42rN45jAZ2LdCDl/01nMrx4Na4IHyb0nBXAUAY1y/ZzrHd2BdqZM8O6SmtvrheI9bt4au+haZzJMaTpZHHCKPGrwxrDewu/zkuExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGjFLwUnTEe1bJDzk4SnMPpEOFqWrTRkwNcKHjoJAXs=;
 b=BKUyS3MVDn20ubFf54Snt8bqdQDQVi53w2SxnDC355qkiOcNu2imuquBUmUCbUOvgppcs33NoxSfEA3iKyQEt5Xy/Am7mwbsJqUldQRXN6O6P+GKTg2BffeWuweIvobKylOEUAxwFGpoXYER37hPrRSxCjtuavV23WVx2xG3dynoIe/ILmBqKFoj+Us1O4eifZAQ8+ZNxzeNDAWdVpXzQE/aWTk2DLlSOEbsPcaxmazxo+v8nc0+gn9ZyIqoUPSj9qpIFEYE95U+/fa2c9BVcVNHBpJ0Q/MtNIVK8uDPd/pMxzCA6LTXqS2dNe8yLIvgk8OplJDhNqPt1frb9ne5Mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:27 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:26 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:18 +0900
Subject: [PATCH v2 1/9] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-1-c3f66ae73be4@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0159.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: ba30b507-1c11-402d-3c4d-08df1c9dba17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|7136999003|11063799006|56012099006|22082099003|18002099003|11062099010;
X-Microsoft-Antispam-Message-Info: BYxSIN/G4VWkL/a0WvHq8G4+/v1+gU4sIF/9AxLc0e8C5rSwY6Dudqa2pYUSkOATJIw0zDN698e1oWBb+9CFd+Ct6y5QxFJqta7btA+pmFpsRBs/4rneWx7C9AxaHCiWtOS27dnboGqcvpgV9ZsTm7g75XBnNUaGmQ9a1uznjJZ3CSNdNJZ+8ODMBba3dNRa75qzJt47vfeD6bdDsumnD+JPVGqxP9Fh1ZR/khftFpza+rtu9KRzVfL10RU4tyYrXjQAlQ0aCX1/vsmERoT0fauNugxMAgeHJUVkN2j+V0KiTNzFADqmJ8J+2F8wGRe3JYCOon8lMUb2NahmNgTFKFbZ20aClNcoMPGjX9YmSom7WXpCs2qdax0+nEOYTpOMTPzNlqtDrMLRABwYR1F8w23DB+PbNAXd2X32gkcqlP8OudRACRsTmoxtXlMzMsVAhjJ1/XXqR5T+QhVQHaxxtpAM6iks5AZJ50hn/UNYmBKE0wNe6VbEpM5TO/HTbOmqD10bTStmRa7TZHcfBAmkoPrUjObhOoM7/A3QE8cIpBp+AkVg5Ykc7jjQk4ShJWwiVr9Gojx8Yvie/Ezv3q7RJNVGqPOsMSRPbtcPvhf5uCQPQ5WufMA/Zzooq/Rl1E6Ap3OVRZyqWd5yeGum/WKhRxx1qzOD7Ds7WaFmP6HwD3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(7136999003)(11063799006)(56012099006)(22082099003)(18002099003)(11062099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9HSFpPU21tSUVHdC9SZ2doR0QrVVI4cEZ4Q3k3RGsyeFFYUnBBRE5oQ0N5?=
 =?utf-8?B?OFQrM1FRRG00SWl0SFV5YlJscmRSMG9YbWR4amFmdlRrS01tMHZ3R2c0U3NR?=
 =?utf-8?B?TDRZNmloRFFoSGU0Y2w2OW1XKzUzVElwVUVSRUV2WmIrc3VSMm1CZDNpSnVm?=
 =?utf-8?B?eWFWUjB0QmNYK0dnUk4zQ1o0NHo1a2V3eE1aOU1JL3JJQzBoVTc2Q2U2U3Y0?=
 =?utf-8?B?aHVobUJJNHliaXdVUkxjdFhON3pKekJ6cWdYVnpQQWY2MkJMMVlTdzVzamNT?=
 =?utf-8?B?ZHlSUEt2QUR3OWtORHoxZWUxWFZ4VzRaUFZXSTdkWm9FZXhnbWovMEsxblRG?=
 =?utf-8?B?OUFEVjhPMjRDYTZMSFB5QUNtaG9XcjEwMXlEZXFQa3piOEVzbUFEKzdKOXpz?=
 =?utf-8?B?dFVmMjZ2UTZaSlZEbEZrS0NmOEhMNFVrTUFneHdRZk50MndoUld1QTFhTHBF?=
 =?utf-8?B?SVpYeG56QkFrOGZiakRnampkeitjOW1qUVQzNVhLd2phM3VwdUxESVEyTmF6?=
 =?utf-8?B?MFBXVzgxQ3BkNlpoM011YmIzT25YblBtVDBzRVJYNGVQN0JjL2trN2xJdnNw?=
 =?utf-8?B?bGZralN2aXFMeUFjaldKQjZtd0c2ai9hKzV5WDMvWnhab2NnakVFUnVNMWx1?=
 =?utf-8?B?UTJGZkFzc0RxSmFiS3lLWnoxN3UvQjAzQWhYZ05EMDB6NFIrUGZjckVFemNt?=
 =?utf-8?B?RUMrR3BSbnhodVlRNm01Mnc5RXIzY2RNZk5UMENhZjhvOGlwYlF6dWgxWklT?=
 =?utf-8?B?QTVrRHdGR09uV0N2d094TjdCcnZ6OHA3c3lpcUdxUFcyT0JlMG5HNjNMNDJh?=
 =?utf-8?B?MUtXUTJtSjFLc1M0TUxkT3hHU1VpaDVRK2xhNGNRM0lmYUZnZUxsMW94ZEh3?=
 =?utf-8?B?M1p5c1RPTUp6d2kxSmsvdE9xWWE4cnM5bnl1ZEl2YlNHMWVNWlRMVkFHUDh3?=
 =?utf-8?B?ZlI2T2VueENrYnlaRlJ5b1hwTzZINUdDeEU2VElkNnlZQmIrMGdTWkVCNmVz?=
 =?utf-8?B?SFFsbVBibVMzSzRQNWIwWE04bWZyQ1pzcXVLRkdMVnp4MHR5YmdXZHg0U3R3?=
 =?utf-8?B?MGM3Q0taNktmdW9vUVJGYzdpOE9JZG5mTVRQOUlGY1c1R2hCdmt1S29lZUw2?=
 =?utf-8?B?ZVg3UWJKcmYvL3FSd1RPL05VbkpIOGs2OGQvb0xJejQ1akNNM0xWaUNhQWFW?=
 =?utf-8?B?YXBEUTFtOVJhQm1nQlcvSEtCWnBtT0dRT2xNaEJEQ3h5R2hkR0k1aGFvTHZw?=
 =?utf-8?B?WXU4RzVSdy9jdWp0TEJVaHRPdkxIU29SRWQxRWkybXNKd0syamZGQUxGbGRK?=
 =?utf-8?B?VDZqYnkyeCtkczlMaDNab3lVdTVGcEMzMWc3NHU4MEpDMFZEdlBuNVBhNFFK?=
 =?utf-8?B?YkZXM3BSd0duZm51cjFjZVM3aWhmbTlZSUNIYWpUaEFFcDBDSGYzVGk5c1Bm?=
 =?utf-8?B?cGQrTVhUTkxmN1d1UUpCZnlZUnlnK3M1YlE1dDdPdW4zTHBUWEVvQTRKWERF?=
 =?utf-8?B?NTFBSGxyODBVS3pMQkJHcmtWT0tLUlRhcDBhR0lTRGpXdjNMNVRmcEl0SnlR?=
 =?utf-8?B?SEJIa1BOcjFndlpnZWlqTm5jVFU3Rm0xclJlNVZuQ08rbDJVRTF4MHkxRG5Y?=
 =?utf-8?B?dkZtQzFQeUhlMDN1ZGpvM0hrNkhCNXVtMFpzRzNrVUd1NkI0U3IwQVEzMlho?=
 =?utf-8?B?UTZSWURJaTJMMnd0Mnd0RFY4alN6M0xzZFB5RDc5SzR5WEFMaXREcW1TTU4z?=
 =?utf-8?B?SjZmcWtiZXV6Wmo4Z0o2LzRCQTY4enBMcXpEOGpPYmVGaDBvdFJEVSswUzJh?=
 =?utf-8?B?dG8yeGhhL1NtUG1Jemp6alY5aUpsUTJoWVNqM0kvZzVXajFlRVZVVkVheERP?=
 =?utf-8?B?L0h4alArVW5WMERLN2tHK3JZYUlGTzY4THV0clVnYk9iWWUxTXpDYmF4eVBD?=
 =?utf-8?B?L0pSQ3kzelVnSTE1OHV1MUdTaW45L3NSRWViNHhDOWVWd3R3R0lUcXdKdkhP?=
 =?utf-8?B?aHhVZ3dGYzZwK21MNHJpWW52cCtWSk9vQitra1BHeGFUbHo2TURicWtIem1S?=
 =?utf-8?B?RDVEcjdIMzJRL3gzbThPaXYyN2FZWWg0LzRaZ295QkkrZUgzdXhEWmc0MVhM?=
 =?utf-8?B?cVpiRm0wd0ZCUFBxVVpNTHBVNDExUDM1TmpBNHd4ajhDUW40dFB2RGNiSm5J?=
 =?utf-8?B?Yzdzb2pJUjl0QzZQa1ZvRkdCaXp6THNSMXBCZ1hsVEN3cDltc2dhL0Z4TGs5?=
 =?utf-8?B?OUxrc2ROM3dsc21IQ1ZWaVNhNUdXVG96c3BJZ0gvZkl2UFBvL2FjUlpJSHVD?=
 =?utf-8?B?Mzl0bXU0d3R3aU1pN1lrYk5uMDgxZytKbWYxWnJIMTRTMEoyeFhKZjVibHZj?=
 =?utf-8?Q?Nmvx6wxBgNk6RyLxLzKRu7hHM7wVpxTjKeM6X8Ij+D8QR?=
X-MS-Exchange-AntiSpam-MessageData-1: tXMYqg9RqWGRXQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba30b507-1c11-402d-3c4d-08df1c9dba17
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:26.8470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rnmMWK0O4r45o7DSu2Pg1cEQr3712bH6pFBahK3Qz+69C1MTGab8dRV66BnNW5/uvOzfzs3zyTHLUwCqnV4FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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

The checksum validation error message of `wait_for_msg` prints the
message's sequence number before validating the checksum.

But the checksum is part of the transport layer, and it not validating
indicates a corruption that could very well be in the RPC message
header, meaning the value of this field cannot be trusted.

Furthermore, the transport layer is not supposed to know the kind of
message it transports, and it accessing the RPC header is a layering
violation.

Thus, move the checksum validation before we start looking at the
message header, and drop that information from the error message.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index a5595da23407..d293d28b0967 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -768,6 +768,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Extract the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
 
+        // Validate checksum after truncating the message to its exact length.
+        if Cmdq::calculate_checksum(
+            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take(header.length()),
+        ) != 0
+        {
+            dev_err!(&self.dev, "GSP receive: bad checksum\n");
+            return Err(EIO);
+        }
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
@@ -796,21 +805,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             )
         };
 
-        // Validate checksum.
-        if Cmdq::calculate_checksum(SBufferIter::new_reader([
-            header.as_bytes(),
-            slice_1,
-            slice_2,
-        ])) != 0
-        {
-            dev_err!(
-                &self.dev,
-                "GSP RPC: receive: Call {} - bad checksum\n",
-                header.sequence()
-            );
-            return Err(EIO);
-        }
-
         Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),

-- 
2.55.0

