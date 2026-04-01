Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D7110F9318
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8358510E283;
	Wed,  1 Apr 2026 01:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAlqBuD9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B6610E283
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 01:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdCG27eJc+Hm/4y4lz/OXVVJqyTNJLJ0X8psMId3AfpOVz8l5H26a/kbKDgQLX4VPgd/9Wks4jwqHJNkGGVXj2Dr3uR8nSKq4yKsf7ff/t9EWwEVQ/46e3cmdq3+fXWyHWBijyg1sfRmKZeYCTyExiIK0HgB/IY1hF45o7INo9XKhZ7evKNmeC2DU2oyrpkpXwu0eWDbs4iSAI3IMoiUnGThOEAUbaZX4cWCfu/Wfx/m7crDWcJGpX9sOgNcnVjPyDTpgqegnmNtMycvMt7aiCkjzsq96Y91aLCM0B6i3jCsQROmGEQoQr+LUAPJW0GAX93QIRwRH8KF1mSQgycFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qle8FVjoWC4d2b8KBcZPlvx+vUrAunhXVDBdSo0ochs=;
 b=oWxufESHDMuWsAKDPbJc/Um8/1luRXPqWZbtHEWEDpaJsepDkfPYLlCRtuNK+2MWrE59HBE3zS0YnWm4YQEFpoyPiUuJKLyTGb/OaYrnes8/Z4cxFA9L6VCdM04e9yh4b8c3Uk/WVy5JRKKw64sSpEbpVVWMYXBi6DdXXGvAvwwy/bZgjO21dY4wt4sdu/AO3zY+w63j9WyNiICmd0myQ+W8oaLj521/W7FAVtclzRxac0bvxTVhxOzvYeUbAjDq6nzwpE+mZxaKFHQ+LNbu6M/UHXh7c9Lk6c3hK9MlmO+84cDZdxzMc/G3IfcpZy6Tr1QE/dXj6sI885uoOkgAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qle8FVjoWC4d2b8KBcZPlvx+vUrAunhXVDBdSo0ochs=;
 b=kAlqBuD9xosz60mu1YVxewK25FhgY/2EtccYxErLodYOmHySC5hfAGNtv1OLtVcxbOZZeuk6BhRewMncXXVEqu3Pxo+YYCFalo6oEbt70MtK8+Kf5Sw/9vosgW51t6P37Fytj5TP9j26omBifUqp9lAw5r/rbtbuwiHV/GBiCUNk76UUK5MmVShwCL+HDyIMwIHM3Tscb4WXT56fIOwIT/vqUHgR4bxloHHeMwyoSM5PUP+B0JBCUOAE/UjjVRXkwKDoJ2DsU6FO1ii69/NbMtClcklWH69dDw9ubdSKTrrHMWHyIpkfnvhgxjdMsa8SZOJ+/wWPmFGjWS8z8vrpvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Wed, 1 Apr
 2026 01:42:46 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:42:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 01 Apr 2026 10:42:28 +0900
Subject: [PATCH v2] gpu: nova-core: bitfield: fix broken Default implementation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNOw7CMBBErxJtjZHXRkFQcQ+Uwp81WQRJZBsLF
 OXuOKGmfJqZNzMkikwJzs0MkQonHocKateA681wI8G+MiipWqk1isBvYTkHpocXRurQerQnkhL
 qZIpU80137X6cXvZOLq+OtdFzymP8bH8F194fdUGBgiyhOSp7CIYuQ2HPZu/GJ3TLsnwBSwhWp
 bsAAAA=
X-Change-ID: 20260331-fix-bitfield-a03f6d1b9e00
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Lyude Paul <lyude@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0261.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1d1b97-2ac8-4648-07fa-08de8f8ff975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: wYIz+yKwSx4w0gqCu37O0VzcqfuxH4MC4yHEjg6c0GYVvTCINWsOFO+1TKyFvWPNBaqkuEu3DeUYUnd3zlRqqEzSGZ+ydbpk/Jb3MCECQsh5RPHtvn9KpT2AspCZ6zYxFs9a6RgXusKNPuBM1SpXz/fsHZAN+aFFg5xuH8UR8mII+0/GTNdtNKDrGaSm5wPPdCZwHE0WoQyL0+4md+7rTlL95JUTQtc/NAHr2FpSISmQNbz0b2qfLm9x1mBB4RcxP+L+9ViF7jphW+lW6s2tDHbRDZytGp+WbKgAUMH/SDkF/3AwDGzK8t0Z5yeo4Vm08xglHg/TrHeB93xEwCvbx34m7AcIo+9fXotZVSYolG5pz4mRLU3TLn18DfHWv1tIKC97YEWk3kTg6+xtXzVnpEts99H9CiHuNbBhgDRTTgIlmMaaJktUpxVM55QONaiszgrGExn8v/O7M7ygtWp/nbRzBYQ9IF0r5oBeT7LnfMlQHPnHzBXH4TRx69W9AmfY/UGCUZJ3luHZWHP3cx6ngoXGhGP04Cw65CDvsv/J3aqOcPsJ3ESrE3bUo4AD1fkaaUZkCce9ghEfba0R9BWmX6oYN8Boa0KSeW3F8vsS3iIGiQcMpYSP/4bWzDSXYt+skBqhXON/jpP0h0AUn6NMcSugUXInZxdKv9uyQB1DGV8reHfi3TRdOPokdC2D98XD1d51uoUMwwIsAIwq5CM3Zn9qyoj45CHR1C+MIiQXK88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBMUGRqRlJNbW5oR2VPQStkZCs3VjVwU3JoUFF4Y0pXNlNzSDR4aXA3RVVr?=
 =?utf-8?B?bGNkOGVWUUd5aXpMdzJsdjR5MzZUMlVzRWY4K09nZHJMREhBZHkzZXFwNWdK?=
 =?utf-8?B?Slc4WmVtRlZEZ2ZXTWxmK1loYktMbndFaTBzV2o2TUhjWUZJUW83eUhUS3dv?=
 =?utf-8?B?YzJMOTlXVlNSK1lvaXF2Y2RhaGhrWGVkQ2lNTGs4RzhTcUk1MTlwSUFHRUtm?=
 =?utf-8?B?K25icXpjaHJraWNpT2FPQ0lmNFZsYUFXajhiM2lFSjJlb0tVQnRZL3hBSlpy?=
 =?utf-8?B?M3cvVnNCSmJhM3pjYkg0Wi9VUmxiUEZhOWtpVEpHNkhFdjdXQndacVFVTEMv?=
 =?utf-8?B?S25MTEw4aVRXYU1peEx6R3QwblhFSk1ZQmwzSkUycFU4QkFHZFo0OXR5blcr?=
 =?utf-8?B?MHRCaU1seVAzSFFBRjlVVDFqUjZaaWQxaUZUSGI2MUdIRWlnWnlPUW1ZSTkz?=
 =?utf-8?B?UEdlcVkzWGI3RldsRXdXbjZac291K2RjUnJIYWxyRUNEMXBhL0pzR0lEeU9v?=
 =?utf-8?B?VUtPQlVobXFLZEgrcUtWd2M3dXpubTk5RGRjWkszcXdxVlFNQ2U1ajdwaSty?=
 =?utf-8?B?ZVdhOGxXQ3FIYythczI5RXl1YStRUEo4ckZlZU5WVjg3bllpdlNSUCsxR3Ax?=
 =?utf-8?B?WG96UnRkNFllOXVZejdiTkE0RmdkUjlBWVlNdDVELzdBUTgwY0I4bG85U1BQ?=
 =?utf-8?B?d3psUmoyUTh4dXVzckVJVmFRWlJCTHhLMDdaUml5dS9vQThZRi91bVRIZkNu?=
 =?utf-8?B?M3JQWU93b3ZhU3lpTytVK3pxeVE4VUNSSkNNNlNnSkJmY2JzZTA2ak90QnhR?=
 =?utf-8?B?ZlNBbTN2U3hvL2NYQTFDQVlPQ25nZW9oWDJHbkhwWnJtSkY2Q2JuMHF4VENO?=
 =?utf-8?B?TWpBZVBURUtXVEdLRFVkNFMrNEdHT25pSDRHY3I1RC93K3pjNTc5OXF1bEFS?=
 =?utf-8?B?d28zWHB0dWdDRTVyZUNWU1orblZ0cGlrT2lnWmRBL0VJUXIwQnU3bWVMMHdY?=
 =?utf-8?B?RUJqRWdjMTRqWHYwUFp0OXc1ZVo4VHVZTXNkOVlZSElhZkRWc0dNbXJnejJY?=
 =?utf-8?B?NWZsbEJFYm53MXpOQlpIY1pvMnhQdlBHL2NvUmhhTUozTW9HV1FQT3JwalBy?=
 =?utf-8?B?MFEzYm5neXZxTndlVWMvWjkvbFFwbnRnOUIrMHM2c3lhZ3hrVklDeHBaeW5N?=
 =?utf-8?B?bWkyZklUdm9EckM4UHI2WjRNUCtpNnFlU2NJZDZibWZ3RHh4MlVrL0VOYWxt?=
 =?utf-8?B?eFZjZjVTTElVT25SMmtNb0c0c3ZYREtZK0xBQlp3djZSa1NyTTRKT2FGVGFt?=
 =?utf-8?B?dnhUcXp6eHJWVlZMUTNtRzZWZnlFOWFsM0FINUZEQlZVemdCUzhkeGQ0RkRn?=
 =?utf-8?B?MWJYRVlqLzB1TDBFUmpwamx6TlE5M1Faam56d3pFMXVJNzdNQ2xDQ1VSZHFW?=
 =?utf-8?B?RUQ5d3VYM0tCYTVYb2xiRFJkQ3ZKcXhuZ2xIMDFuajNyNEJrTU9ZR1Z2bXZ1?=
 =?utf-8?B?WDBpMlZTcXkrN051dkNLRXFBSUdUQW0rUjN0RE9HamlVcHozbkIxMUk0Y0I5?=
 =?utf-8?B?NDZOaC9KejBGS2J5TURpbGF5S2kzNnpWM3VHbVpSazA1bzJGRHB4d2ZlS2Jn?=
 =?utf-8?B?emEzN2tRM2RYc0pjTjZaT2JIeHlRbVM0NkJkUnZ3dm1MOGxxc0wvbG5Eb1VS?=
 =?utf-8?B?TXRsUldJMENsektETGR4WmlvTWxBTDNSa2NvZlUxMWp1WWtVSlpkK2NSK3Fj?=
 =?utf-8?B?cHA3K0s4cjFWVDJEL09TekNwSnFHM041OGZOMzJmc2ZFVS9GZ0kwOTE2b2hm?=
 =?utf-8?B?TGxuK0toL2RMSURlaGg3djBDaDJtQzNlZDBVa2t2Mm45WDJHbi82eUp3VXlU?=
 =?utf-8?B?RWJScEZkbWhNRStxY0FKOW5UZS9SQ0V6Q0VhZ3lNYjZDZjRQNGQreS8xQ1JG?=
 =?utf-8?B?dVBjQUlkS0I3ZDg3cmZ3QkVjQVdNcG5qbWRLZDJMbGtyMjRpaEhqRVdsaU9D?=
 =?utf-8?B?VGU0VXFNMzlGMVliNXlHZjFJMnZvaE1LaE1oYzhuTFZDNDZCTkZGMGpFYWtk?=
 =?utf-8?B?WlV2cHdJenY0MldnWFBWbEJPS29XNUNCUmFDeCt6TG1Pbzl4MS9abGJuTkdF?=
 =?utf-8?B?TWpQRTF6N2hUbW5yaCt1NjU4UStuUnZJREphMGJ5S0ZmYnpnS3V2TGFOR1hY?=
 =?utf-8?B?bFdCQ1RRbWJzZDlFemJtVHY3NUpjTkRQTUV2VmdFRFkxYmQyY1VmWVVUdWRo?=
 =?utf-8?B?V1hUeFY3enpEOUFVNGgzQys5dFVlRTZDTURaczJTSTRBTjdmemJ0VVdCc0Ir?=
 =?utf-8?B?aTBLMWorL2hDM082M0k0YVBCVjFidGpSc2NjSFN5cEtsT0RQT3Q3VDFsZFlP?=
 =?utf-8?Q?hsJb4y+7B++sqGW/95jZxxmf+TiNpTeR1BTQUUpzbbVK1?=
X-MS-Exchange-AntiSpam-MessageData-1: MwOdTu4kbDpLcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1d1b97-2ac8-4648-07fa-08de8f8ff975
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:42:46.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzEF779jkgW4fnPSRYVTwi0oN+OwecV6IBcmEdvNCejaXmRFZU5vZ2I9dFpxL+YT4rz4AHmUp0frgMWWbnED0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

The current implementation does not actually set the default values for
the fields in the bitfield.

Fixes: 3fa145bef533 ("gpu: nova-core: register: generate correct `Default` implementation")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
It doesn't actually set the default values for each field. I know that
bitfields are being moved soon, so maybe this fix is unnecessary but I
saw it and it's a simple fix.
---
Changes in v2:
- add "Fixes"
- remove test
- Link to v1: https://patch.msgid.link/20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com
---
 drivers/gpu/nova-core/bitfield.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 16e143658c51..02efdcf78d89 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -314,12 +314,11 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
         /// Returns a value for the bitfield where all fields are set to their default value.
         impl ::core::default::Default for $name {
             fn default() -> Self {
-                #[allow(unused_mut)]
-                let mut value = Self(Default::default());
+                let value = Self(Default::default());
 
                 ::kernel::macros::paste!(
                 $(
-                value.[<set_ $field>](Default::default());
+                let value = value.[<set_ $field>](Default::default());
                 )*
                 );
 

---
base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
change-id: 20260331-fix-bitfield-a03f6d1b9e00

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

