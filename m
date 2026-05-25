Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36CFCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3904A10E360;
	Mon, 25 May 2026 13:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qo1IBVOf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD5710E360
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/9Mjd9AVatZ3qlK3ZA2os0iTNrNCmBj9r4bAaTv5rhXCQgDo9zUkEFUrSq2LlhjMgp4LVnmPakCvbG24SS3TBLXV/mjsderIoSivu+xIgDwIVpzbnxcvOfYOJ1iZLIO6gYf7bIMFuOhONCQSszC5HwLJOLs82zeKXIdBFjDBnx6/m77HSuhK67615BZKqAODrdrzFXdw38CC7ps81wnudTbsiFI5M7Loz9bpi03ZWKpPgz8hfQUvSB3aQCtcd2ZpisPz5tIKRNS1VE3+IHGlxFrE951fHivId9eUVFJucs0zqjFbBRCnu8xG2/aQ1FpJNAVDNrQpKqXXe+u83O4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REUh+d88oDvWs0/ZeBNqMN14GinHMDvUgP57pNjzJWc=;
 b=R8+TP9MYIj9jsnMHidzgVcA8b8WLTmM1wUrRKwl+ZuxMiYgmf6hniMZQRSvxyN/WynY4j9KB5eh3lvsM1LFLMzrOP/OHHCXAHLs01CRKPnk47hYN76FSxMnx5w0rj4bKRVxfKQSRFRiq82CdMx7S+DkSFj0FiFU/97XJ4YL2KgTzk7n2qQe9wXGaV2gpu6xaxluvtjKQn/6x7dbWLSA6nr6zCuOMNI2JmKODZvUoS8aE2KnV10aKD6eGJ+sv3GrXAhBMxhDlNtoVRBeU0+5XtygHyk9/9I1+tt7sjDRDzTkovn1Vj6OdLMaS1K4HjlkIxRUNpAe7mSmpy0f1z+qESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REUh+d88oDvWs0/ZeBNqMN14GinHMDvUgP57pNjzJWc=;
 b=qo1IBVOfsK+4vbRxfzp8+I3l1Ve9iCbt4L6eDlfTMaWZLzqSc5jvN3YGkQxPndg9mqe05p4E3bwU5Aciy1/OCCyownB5E1cLDwcWuleoWZPQD9hjmUdQMXm21wCyNBwGxWD+zd7X0PpWeteXDOcR7cRqc4rcv6Wu3ar3/UWqNX96WbdjP4v/+AOXk/xsCMW6tC6xTEy6xgf6gHASL/g5D2/FTmo8LXiTN+gX6bTSk3nn/51bGDG60rYaUDoj6sk01NusMXql/6mzBuPUJVESB4zdpEM/SVWdoQPm+u35O8E7evIWSI9hUeSVyMo/lTJ9u3Fvrz+bVUAm05KQA9F2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Mon, 25 May
 2026 13:59:20 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:59:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:40 +0900
Subject: [PATCH v5 22/22] gpu: nova-core: vbios: remove unused rom_header field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-22-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DU2P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::21) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb010c4-0798-44ed-5794-08deba65d149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 10Oy9tHts4ath7a9zeYVo3KXTrAPMoszxkITnLv3R2XTYEtsF6DfDDjICpl636W+sULuE04HUCr7zNQx/J0340yTw6xPgjYvWN8VTS4HvFu9ji4Dcl14EmUohvGftwbgs5dTu/N31R1Sp6dKaHqHpkUHcd2t2UhnqSrD/EsN5Q8rDFk7vc9drAbx+lz8aGViijxl7U3lZjKxBDU35UGwzGeD5txtTlydXIe39dI67+VZIigTGaIFnCNtaMsqkg9Y2eJjlvwa34OGbVf4AT47tBxK2J9BJUtxhC522RsDaTCpaS7NjZ41YXax9P3eEG7HZHAvISe9WTuA8iBJ6vToAjXnbb00eQQDjje4lxjoj/unSED2WCZNfGNzf0Vi3pCEqo1je9ET2hZ1sX9VMsl9hdInPgWZnE/Y13Eb0kw4ESqhPCgmoNT+lIROclE7P88bQiyH1pIMUhRDqMDwnrIg0q8THkS0ABYdzaPyksn69cNWQba/ppwoH/lol3aJfuTABWDIZGWn+dZEo2HP8oSNQeZ9J7fDPl+Rrj5eSYQEUcHNU8Qa/kJJHNSBSLT1fIWdzuKNGnSLb0vYegV/kz87bng+WyWRUNRVHn85/iVVTcAwir9nUtWatqAZQWoskxKHDWw6sUMvXkIyaPJRcIwH2a59bQ0QDh+z3HT2UUkBZVZv1duA504SW6ACyB0qznzr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDV2OC9rV2VNMzJxNFArNGxnM1dRWW1VRkh1VUlsWmQ1eW5lZDNrU3lpL2Mv?=
 =?utf-8?B?a2RmN2lqQjF5QTg5a3cxZXhPOGd6bTk5UWNMMGFUSjBqT1JCeC8vT3pJQkhh?=
 =?utf-8?B?RncrQVhmWm5uY2FYNDBFcS9HRU1zOHRDcXNSU2REb0p4L1hyQmh5dmtialdP?=
 =?utf-8?B?aWVVUU15YWo0eE41OUJHbnNCNDFrZjMzdi9id3BlRStFRUozamZIQkhHb1Bu?=
 =?utf-8?B?MVhCMU5GYW1QTXdVMWs5THBCdFF3TWtncGpIN2RKeHYzUlVLT0tmbmNtMjE1?=
 =?utf-8?B?QkdtUDkzQTFvZkV2dTZWYWNIOEgycUFtMmN6UE1xL3FjN08wcDFRZTVMQSs1?=
 =?utf-8?B?cVc4OW1hUHZwWjU0aVZSOGxVMXpZZ0NwMk5Pa1B4TkUyMm5sV1RyTThlc3da?=
 =?utf-8?B?bnBja09IOVZNVXhHZHh3bnR1bXZ3WS9JZmxiNTA3eTdpcE9MTlhFT04zQnZL?=
 =?utf-8?B?bHhlenVhbm0xcW1BZG9STExsNWlBVHZxTzA4dlN0REtwa0hDV1JKZDF3enJl?=
 =?utf-8?B?REd2MG5WMzJSQlJ3SmJNaytxRTIxQWR4ZlRSbzVTU29uSmxyVVhKbktWbHBj?=
 =?utf-8?B?bTJFK0hENWZMUWJYdkE5RWhhR1hrOUVrNTBPMU1VRmlxWkZZd1hlVkJzM1Bo?=
 =?utf-8?B?OUZJZzNoM0d0KzVCZGtNQlpqcUdRK2xmNU1MN3RXRWVKS0gzVHJOcWd1ZWhT?=
 =?utf-8?B?R2NuQXp0SThJV3N3S2lOTWtUdGdBOTVaSDQ4Z2N0SGU1ZUYvM3RXVWFGdEdI?=
 =?utf-8?B?MWFEZXUvUHMxM0JPSUJPcW1lMUVUcmJuYnd4Y3N5ODRxU2xHU0RpMnRZeXA4?=
 =?utf-8?B?eG1xMXh3N04wekFCS1VYZ204cmxnSVdHNEw3WWlRdXNrY1ZaTTJGQnBFRXBW?=
 =?utf-8?B?OTRZZ3ozSWtXaEMwa2ExanlmNW9VbTlCZ0ZQQmNrVUpQUTRrbnBZKzNmOUMx?=
 =?utf-8?B?ZHh2cFN4U2p2RUdySXZVUXA1K2RIU3hidnBxanBNYlFZMytCL1hYUnJ4Lzdi?=
 =?utf-8?B?R1ViMHRzdzhyRlpjdkRwQ2QvOXc3Z1BiQkxLd2VjM1RTZExuZEtNVEt1Mnc2?=
 =?utf-8?B?M29KSUg3WXVFQXl3Y1FUVll2N21xclUrdVJaZjVlaXhOL1hPU1IyTlBjUGtS?=
 =?utf-8?B?Qkgra2NWcVUzUWFqRzhuSDE2VXk1Q3gxOVlvQ2NEN1E0YWo1Lzl2MitZdHZ1?=
 =?utf-8?B?TDh2SXBvcWNjWGdaVGRBTWtDQU9nbGVkeEVxdllGYXVFYVc1aGRtZmZsVUhE?=
 =?utf-8?B?QVJMbTlNVVAxT3FnUytQYkVPQWEyT3k5RUpwVE1MTEZMK09LcWFXSzVEWUh3?=
 =?utf-8?B?TWVLVi9KbFRlNXVNdWJPTGtKZ1YxZFZabHpHbDdXWlBGdHErWGtZckRQWWN4?=
 =?utf-8?B?R1BQOSs3TE1HYjBuakZVSzdrMzBwcWxWdUt5YWZ1emJsQXRaR1k4bmMralN4?=
 =?utf-8?B?RzVSZTZZMkZNa3BDa05qTnhIUFNRT2pnSzNnNTNCWXhJVktrYmp1K0QrR0N2?=
 =?utf-8?B?Y0wvS1FJc3pBck10V003cDYrc2VUZUlRQ2dpSytDcGZBV0NyaUpnczIwQXhw?=
 =?utf-8?B?dWZZSUNGdFNDdkp0bmNiUjE0elo3UnRiMGZ3VWNnUFFwRGhUK2lSdGJmRHZk?=
 =?utf-8?B?UkswVFgrYTJoL0FHRGFOK3hSWVZiY294cGYzL1dRZVJTNWowRnJmRk8rSmxU?=
 =?utf-8?B?a2R4Y0lVRVBRc1dPdW41R0kwbzhMRTRjS1BQR2lxc05XT2FDVVlLS1NMR3NN?=
 =?utf-8?B?L000NVAxWDlsYVRvc0dSSXBEWTBmMnhsZmVwb2JMRXpWajZ6bzQzS3FhZGFo?=
 =?utf-8?B?Z0pVRWRxZ3lsejlaYjFscEV2MEJkUjBCOWh4b3RySHVnSFo2YnFVYkhSSFp1?=
 =?utf-8?B?N2U5QkNnQ2xuUXFIVzVlbndMeERKM1MybHB1YnhkMHpHbXJDU0JKaFIrNm9W?=
 =?utf-8?B?djdERVRISkxIc1VBNjlRV3FicThmR3JOSlovWkVFOEI2eThmam9UbWxoNGlz?=
 =?utf-8?B?ZUdZMHYvQkdDTm10Qkcxc3QyR3F1VklRMW80d0JIcE1JaFBhS1BCWnpZM1Rx?=
 =?utf-8?B?RDhzWHdwa0dVN05xZXVWNmFhM0VSYVFyZGd5ZWhQclp0TFU3Vld2bFpNYTBE?=
 =?utf-8?B?L20wb0hRdDd4c29SZkcvVXdndW9HOVJ2RGdnM0xjRFZNdHF2YWZTYW4yUFVp?=
 =?utf-8?B?QVQ1aWtOM1NvQmdhdklEL2lUZXZZdWdLc3BIMjIySlpNZHJVOGRtbmpWWnJM?=
 =?utf-8?B?Vk1zeStCSGRtaWt0TmtyODBrczBqN0VCUGRUNkhzaWF3YzhVdVZHU1FoK2Uz?=
 =?utf-8?B?WDVxYU9TR2ZBYmZpMC93ZER3N2Y1bWl4U3RFNEhTWEVveHZTVWRTZVE5MkJO?=
 =?utf-8?Q?nuE1pMND88bQ8kk34+Gw0H32H7jhGFVrASxQzpF3g/tbR?=
X-MS-Exchange-AntiSpam-MessageData-1: c9m5PRKI5Rss1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb010c4-0798-44ed-5794-08deba65d149
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:59:19.9901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ7pG5uHsCuoBKllq5kffLT7/XD6m4nn6aQl6UAiZR4MvYpj4YOSm2N5ObH3PQfA1TQxPNfsFnsmveqiJzhqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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

This is only used during construction, so we can remove it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index b14f9ebdc68f..c0bc1008ed75 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -663,9 +663,6 @@ pub(crate) struct FwSecBiosImage {
 ///
 /// A BiosImage struct is embedded into all image types and implements common operations.
 struct BiosImage {
-    /// PCI ROM Expansion Header
-    #[expect(dead_code)]
-    rom_header: PciRomHeader,
     /// PCI Data Structure
     pcir: PcirStruct,
     /// NVIDIA PCI Data Extension (optional)
@@ -741,7 +738,6 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
         data_copy.extend_from_slice(data, GFP_KERNEL)?;
 
         Ok(BiosImage {
-            rom_header,
             pcir,
             npde,
             data: data_copy,

-- 
2.54.0

