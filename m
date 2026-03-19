Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932AD1090233
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E612D10E8CD;
	Thu, 19 Mar 2026 14:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vx/Hxdlo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC60110E8CD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7+KjOvN5VTNBlJYqzctx5Ohg8Yj2A/cOU6RfbiljbmLXZIuxU61h1DZvx441oBY7Mh/KPsBZNrlz+7QdNKzD7ahTr436jXkumBIN0f+GOu96PwrQ3FfUxCVCjzSA3Tldx2z4epWKcHbFVYll0c4jljh9e5pLSAfuPmTL9U+U2zU9l1u9/6qvQtFQDd5y2HQMNMmW6y1d3l9R4yFzJQQUN+lozWEpg7j1DM+fRHJdD0xmxHiN1FWEOnjwLSA8CeJTaiRG9Ply88z4Siirdq5SG+R8Kru4GwVGDtbVMUnLfhtnRDXEFxu2WaKVvsoR0ELnUlnBvWwQo5WdtSzZEzwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9Qte7+dgjV+n3esLuMxEJVRrlo+w/8MHqT7SIBpCOs=;
 b=wXY6MWb9htjZTq7pwy0IUgi75ydMw6CgpftZcyOMYamvm7UjU8ExG128N8+e8abV2czeJ/anwSQuyZT7BCMyYBCU2Kvmc0tmvbeH8BC6nmbcQxPRjWPhpmM+kpDzPn8iFG18mHDV6ZSJ1aiK9fwLiOkgIz/7JZs5HTDf0/xUopiRvog+nf2VN8mK69hIZwJw0TqKTIdzAAX3SI7BdAlaOwKOXtuEsGwjpSc0qG93QFYUMr0ghXOaULTD2kkHtHPV7bFBbOshDdFG4j/A9iLRG1KimfGtntEPbk1BYlDsLpaN3i/c9eULXeSRwsAjTcOerYN5Ghv5fvwJGZ8oZ2Ifuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9Qte7+dgjV+n3esLuMxEJVRrlo+w/8MHqT7SIBpCOs=;
 b=Vx/HxdloIW1tZHnPxLXbn6UWihiHaDaDKsjdqoc/bLHmimeY+4sDCZ6955Pz/68W1CmSmHFe1Gk9kKR0lZxN7vkagplRdfwBSzSGlEvVYP+qo9JD6cLhc/8U/kPT2quabzkmGURwmmqYKS1os8/nUnE/EFmC5Be0pCHIpx/W7Oxl9gtFFezUTmSjqXIc7RmU8yY6lRLlXAbaEzxkMISO259bkbf9VCiX+TCp4hIWpaJPfk0XSrp/kkZcLmtagCJApcZ09x9AoPfIn6sA6KQKR3cucyFLyN09Om1nK5MeJj3zsBJc/dFugfmLUlNnKeLlM533Xt8KenFEpQYV/q82zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 14:19:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 14:19:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 23:19:54 +0900
Message-Id: <DH6TP9BTRXUW.237ZG7ZO8S9NZ@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 4/8] gpu: nova-core: convert GC6 registers to kernel
 register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-4-22a358aa4c63@nvidia.com>
 <DH6E45B9EBWR.1MAR230QYC2HG@nvidia.com>
In-Reply-To: <DH6E45B9EBWR.1MAR230QYC2HG@nvidia.com>
X-ClientProxiedBy: TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fc867d-d6df-444e-e16c-08de85c299ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uMCQsXv+Sjbu7rACDD+SRfYkk5NV91BcW3yQYlRJEzVU0tH5QDGgWCUZhfwgDbWCF7bU1FzUWnNtzEFi+EEjVbIo6vZ8NhXkyaQw8cOLEJQ3PHw/Hnplk8A0VTGeegknMUA+cZwQq3ZHq79zC8wpskRywS1ff5Hso/eW4Bcip6DWO4e/qsS27mqChI/Zo5r/Ntfvil6V+dkkA7/ATIpabDBK/C7TxerMgtbH3AAygzhuPhBJ9AH3q60FQagpy0/Qs7/0pJ8aFMmtEdp08PZh/nDloUDVK/nUJSqKYK3rjVXJM1jpzEBwFAXYVIaPkv3ozmRNT593RmGwX/0/ocAwKc65naCWze8iIn3e9UYdQ/yaT/MQvVFeKJKuKH/Kg6H0lbwf04HYj9JDeMIWNpJt1XVa0AHgX6yP/wGIKBosJuJa6SoKhYSmAX0vP1ds9x7rZfFHG2ZgMu6bw9RhPexXQVNBX2IbWvDB3j7kXcIk3JI9doJS2ZbM3iLFnkQ4Z/aW3/Q7qCPj9rCNdNw9gb0pqz7AGxm60lJhWghaPV4IxPL4YdXU+YsSr0XM+idYtnyUikYcKJ0r/heJhWlCGRGNVxanvhfBtNePhPTe43clVblUIi5JKAh31KkqDDEBpaZdr3Hwz+lPKbERkOEwDWi7VWri8DE5tppQSyTPrpiuo3V7x/eAu5Lbie1jormncS+Rbwa1XNyjhVUCkkKj5dO04B2Z8irJVxiKat1PL4GTKSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9lMVozeUhJajQzd3h0aEpETVdpQzBjamxybUhvcitrNmZPSDlMOUVyK2NL?=
 =?utf-8?B?N1VzVzI2bFJ4ZUVXM1hSTS9rdE1Ib0E2RXE3aFhHZXd4WGdodXlDZU9TdlNV?=
 =?utf-8?B?d1FBQWxMOVFxaWU2S25WK1pQOC9kT2pkdDBDOEY2SFZsQmx1Z1ltNzY1ZHpp?=
 =?utf-8?B?aDd2Y3RoSTlLbyt1ZCtoUEkwa3l6ekJ6MnZHSnZBbkZKSGpDT0dlbDR5MzBh?=
 =?utf-8?B?TGloY2ZhUXNvMU02UGd4RDZrNStqemxscE1TTW95RUNMeFNqeThZT2xLUjZz?=
 =?utf-8?B?bXBubGdWaFNmTVMwQjljU1VXQjN6azBLQ0d3dTBBRXMyWjNLU28vRFBWVlha?=
 =?utf-8?B?ZGdWVDNMUHlrSGNZckxPU1hjdm9ULzFDb1lHSDNBUUo5RFZJK1BrTGlUQm4y?=
 =?utf-8?B?Q2VnOUw5ejdFeGZnQmdQME5tdjJneGJzTWU4dW1ZNS9yejZkbkduVzlnV0R3?=
 =?utf-8?B?VWhCeXZrc2xTbHBzaVVpRCtlZ2QxMGgranlKK1VmcHBHbk5tSXM4OHd4SDE5?=
 =?utf-8?B?bDZHSi9Qd052dStsaTJRT3FlZHJzcnI0UHJtZVNMV0w5Zmg1cEZZMkFlMW9s?=
 =?utf-8?B?eFNRSS9BWFpYODhGbG1NRDhGYUNYazBDSFBVVVJHMEtLS0prZjRCRkxEajRv?=
 =?utf-8?B?RDJENW12WitJZzB3QXVBT3Rqa2pFTkxxZ1VOckFPWElGekY2RUxsWlJhMlhi?=
 =?utf-8?B?YUZHdDMrKzI5bThUM1R1cW9QeU5pVkJmQ0FKQW5jdDJmTzk1cVhONTlvam5D?=
 =?utf-8?B?a2NncFJ4WkRQMGlaUlZ3L0orSGlHei9PMEZjN0FXVmt2KzhEWnBnaG5RYXFz?=
 =?utf-8?B?YjhQeEd0YStveHo2cjkvMzViellSQmVaQk5RVmNFaXRBRm83Wis3N3dSMFR6?=
 =?utf-8?B?MkhLMEd5clJ0UmlsYTVVM0pyNXFVRFE5N1lGVEp1MEY0RHl0WmtiREJldWxn?=
 =?utf-8?B?YWgybDJ5cktUN09OdHhzalZtayt0VUY0UEN3VUpPYUh4TjZmWlhhQzNJZllw?=
 =?utf-8?B?Z3ZIazBlSnI4Vy9MVWJLVkFadFN0MVQ3SzBXV0ZNV0RPSllOc2UzNE5zeS84?=
 =?utf-8?B?R0pHNDQ3bk9SalRlMGVDeHUxclgvZ212em9UYURVSTZsTS9KbGg3TWNtOUho?=
 =?utf-8?B?RmxTblJwZ1ZSeElBZGhwRWdiWjdrSnlkTTFsN0N3ZVRnMTJkN0xoM2cvZGFT?=
 =?utf-8?B?S1lLclhjYkVvdlRCaGhqTDZnb0VzMHJNWlQ1Z2Vnb2RGelU5Y2tUMEdaamd1?=
 =?utf-8?B?R0xwWTFQK3ZpaXVoa2JnYzArVlJVbTdTYk04KzJ0UlJmSWtzVkR3MkZ2WUhy?=
 =?utf-8?B?dGFOSThxeVc2NWNJNnVxY09XVHM5U0ZGUkxyZUt0K0VMdmtJYXgwcDF0dkFw?=
 =?utf-8?B?aDB0WkwrUGVHQ3lnQUZibkhHOUFoS3dkSG5pL3JhVDN4UWM1dkJQeXlrTzBK?=
 =?utf-8?B?YlVQdnVhN21SVTcyMXY3S0Y2aTF2azI2MjJJN0FBTmUxc3pVa0o2UzRmWkpD?=
 =?utf-8?B?a2RkRnEwYmJ1eGQzaE4rK0VFb3ZsSGE3UEI3cFBSUmZlZUJWU3pWV3VJMGVQ?=
 =?utf-8?B?bE9QZVM1ZzBUZGYvRUhUU1ZobmNpejhYSll4c2NndXBOdGVmZFFTY3RFSU5G?=
 =?utf-8?B?MTAwTjZWZmIxakx3cm5Ia0dBcVIwVXFxWDVSRUs3cVE0bWN6QTdTNi9UbVls?=
 =?utf-8?B?R0Zqa3lZcnA2ZENJYTBKaG5RQ3BldmJKU0U5aklRYllHK1MzSnBHR3NLTk8v?=
 =?utf-8?B?NGVlaTUyZ0lpU3RCcDRVVlYzT0xpTHRPd052YkYyaHdNYTFhRStmVFZyQ0xn?=
 =?utf-8?B?cC9SUkVoNkRPY2pZa2IyOTRIdHphOVU0dzBsWWRiN25Pd2xzaUFISDlqYjEy?=
 =?utf-8?B?TUpBQjltRGx1OU1jMFpWSlF3ckk3eEJUb0R2aFZWRlZkRngwaGRlVEc4Vmw0?=
 =?utf-8?B?alJJU1VmZW1wRFRPc0xBd2lldWRhZnJpRUJTbzBaZS9FVlI5TUlhYUwrRGpY?=
 =?utf-8?B?cTkyYkJ1QWNuV1d0ZENtOUgxa1g1c0tMQzExZ3pnUkFpVlZwZ2hRZUN4UnNt?=
 =?utf-8?B?dHkzRzVvWWJUN2ZGMXBKeWF0RXhVdGdYd1BmQjJCSSt1VitvZG9Lbkx3cElp?=
 =?utf-8?B?RnBOTm55enlxQ1I0VGZYaWRhUXJUZW9iVm1UODFpSEp0UUFkL29Yd1F5eW1H?=
 =?utf-8?B?cVhGRnJwc1o2N0Qyby9qSEdHelp3SGJ2Mng5U203N0JxSU1idXdZbHhZc1Fv?=
 =?utf-8?B?YzdKb1pIaGU4dE9xcXBBaHRCaFJtQ0krQ1JSYTkvTEMzKzk3RGxEc0kzZEsy?=
 =?utf-8?B?cW83ODNkb0N0N2xaNmt5VUNXVzRha2t6M2Y4NGg4UkRGdVVvakVsWW5BS29E?=
 =?utf-8?Q?jzOq9BB7EZ0eWwwF4c1FxECZn94OLKZU40HJLo02Ot4mf?=
X-MS-Exchange-AntiSpam-MessageData-1: fv9TzxAb6X7JHw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fc867d-d6df-444e-e16c-08de85c299ce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:19:58.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY8CrT/23PW72UznBvbVPey/xfuTOG8ye/Ro9Tp35jL9wMauIi9yWXchc+vcidaeu6yHzspT2k9y7QWT5nnc1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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

On Thu Mar 19, 2026 at 11:07 AM JST, Eliot Courtney wrote:
> On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
>> Convert all GC6 registers to use the kernel's register macro and update
>> the code accordingly.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>  impl NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT {
>>      /// Returns `true` if GFW boot is completed.
>> @@ -252,16 +253,17 @@ pub(crate) fn completed(self) -> bool {
>>      }
>>  }
>> =20
>> -register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
>> -    31:0    value as u32;
>> -});
>> -
>> -register!(
>> -    NV_USABLE_FB_SIZE_IN_MB =3D> NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
>> -    "Scratch group 42 register used as framebuffer size" {
>> -        31:0    value as u32, "Usable framebuffer size, in megabytes";
>> +nv_reg! {
>> +    NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
>> +        31:0    value;
>>      }
>> -);
>> +
>> +    /// Scratch group 42 register used as framebuffer size.
>> +    NV_USABLE_FB_SIZE_IN_MB =3D> NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 {
>> +        /// Usable framebuffer size, in megabytes.
>> +        31:0    value;
>> +    }
>> +}
>
> This is not an issue with your series, but why do we have
> `NV_PGC6_AON_SECURE_SCRATCH_GROUP_42` which is aliased to
> `NV_USABLE_FB_SIZE_IN_MB` and not used for anything else?

This is just to follow the register definitions of OpenRM - the actual
register name is `SCRATCH_GROUP_42`, but we are using it in a given
software context where its role is reporting the size of the
framebuffer.

We could just define `NV_USABLE_FB_SIZE_IN_MB`, but that wouldn't
reflect the hardware manuals properly.
