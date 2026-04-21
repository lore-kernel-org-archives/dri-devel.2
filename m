Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8900BF8FA78
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0270310E8A8;
	Tue, 21 Apr 2026 14:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UM2KgCqH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623E010E8A8
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 14:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSCQpFgH5phQQrUP0d7n/lDfYP9cY5ioi03Q7V7OT8QzhPGobtal5UN2Yd5O9Ja+x28npN8IF/Bw/SYGXwRujz5j55PoungeGswybrbcPxeEquKtWYQxdrsaY4ALbZ/FZvC5jpTwfBo3A7gd4c7wuXPI5N4K2n4CD85WZQ37YkGpXqQlUT0ucnV2v7uG+uRzSiGMw0bLCd/rkeUXlGiPtJdIL739ZoCF4UYKR/IP5DuJeFVLx6v+86AeHZ4V6m5jSK4/OzK1kbNg8P4MX9qrRm8MrxU4gsmvaIDMA/0M9uvTY4aq4096oyk9Rv8zp0ttJyyWiQunLCKgbDCOnJxg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIWG5gpIaGvGRnOZOBy0W7t2iZ6Nu9UzdQ/Elx/W634=;
 b=H0O8u3sWPp1P4VNpLRpKxXvgfCnnh+DBePlaj+1RGEnWq5im6ZqfvYCwhVdcAujAlC2FilxxGpWOwYFj+g0ubjzAKXQJIJ593u62EoKb/7dTyi7wtDB19xac/uM36b1B4MlH8oUyGnFnfBIR5uv3ctAOqydT9qONYNQ3fpVW3vvdwHFU5/cjSx6yGCh1PCXhb2hz3vtueEvnf93NURNv2W8yNqs8bUsFEMcOtbyVgLfAcyQO6ikX0UDbvsTRF+IimwBb+PsJSVFWcfi7ifohe5S+r8uMxFhTF/HpoA+sNZV32a60t7WnFRizo22rnni6W+asXZglgTWC3upyymsA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIWG5gpIaGvGRnOZOBy0W7t2iZ6Nu9UzdQ/Elx/W634=;
 b=UM2KgCqHtqmGf5wY+VAVXQZSkeirK5jXkyQdBivcSqjJgEpzjudEwK1aiYIXdPAoBjwCrcMCrGuo4cxOl9vcHfJWbmImlbbSnKGskMZI0wK0uB9MS2S63R3g9k/HpUdXtsbJpZPKyFMC9CuwLL2he8Yrx6va104I3RC4F+fJsIsRl6nLaBhgZvSc2t5K4MwVMGBbF4yLrXASD0sQGNKpA/ww8EKeBVsrHkglwPphq69wNeiUmBtFKi0ckYi1l6OxRCcd2JBk46g8bSo8I9b/PoLcnAk6ESJigW/gCfjYQlGgngvX6VcHJLHi6xQoxN39nwDtb6aQR3chd0lRj5LK5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Tue, 21 Apr 2026 14:45:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:45:13 +0000
Message-ID: <a536b70d-6d55-480e-8f2e-76b4b70b8916@nvidia.com>
Date: Tue, 21 Apr 2026 10:45:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
To: Eliot Courtney <ecourtney@nvidia.com>, Timur Tabi <ttabi@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, "dakr@kernel.org"
 <dakr@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Alistair Popple <apopple@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
 <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
 <D7532B99-704D-4021-957D-1B50E33D29B3@nvidia.com>
 <DHV2V1WWP7EB.2ZCK3X9RBH9I5@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DHV2V1WWP7EB.2ZCK3X9RBH9I5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:52d::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ff89b6-a874-4026-2591-08de9fb49830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18096099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: isO7EDMabIffJYtYT3fr8EZElKqa04yrDHZSwlD5M1dKmxMuR03mCEghuZ5B3vRc+fx8WjYfudOTF/URUOQQX6JGIH275ox9tlfPooOyLylZy/yoBC0JiQOFMVj1zWMEOF4wjxQC4gOypmfU/lPX7BOkNRZCNVEK+G8fRNJ4sQIUjVhoRAt38tLaYccKFmTzDmSI6NrZL07DUXctemt/9UaHxDlxPs60IR9Ya3CdlvPZ/1YlOR39SWSx3aJuZevkwEdWkLsoqWNp+N3F+Q05DDNG3Mg2AKLe3NJl4Ce+x700d74CcUz1qm0Rl+f6ylj4i34D9AXCzPTzSj5Tfl4jO3Xhvpr9MtuyjRb1CmEGSwXihMjMkbZZ5VaGhD0beFWHbOXMi0eBOa6cwNJQqmujw6MY+4zSdo9fRCFqO9k+I9KdcYtAJd/8cmY/cwqPoNQ2Li5jkzoYubCYIxDVy7L4ZIjgTwvxl2ib51Sg4eMFbejRFKUsHayzl0d22eMt+dY9PpEndsEJh4LxbqbloRqjXPAglJZ5OK8zcpKLLHJN6ih6AISJ+xwuypiMk7GcHAvZzn10d1BP7+ug4pLuNCMdX5iBAcQ65jz9hlCevw5KfICxJx5ol5kq03CYEmr5R1z+Q3cVjsGdosKg5LqpnnR3JrIqy4OMQxsbJ880/tkmqSpoFmoL9fS23LG7CyLUwss3BT5esuAljIjAPDKzh2ESRyhIeSWJxibVbBmwjx4rtko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18096099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHc2NjhHRms4aGtrQ2hYNmJPcUR5Zjc0c0dzTFJFdkRUS1JRNzF3SU9INWM0?=
 =?utf-8?B?d1BteUNGYjBuUGlsUzlTNDdMSjZ0aUdKeXM4eFUzL3BKYXU2clluYm9wUjdr?=
 =?utf-8?B?UjFielBpMENGRjQ3YkFodDhKNEFVQlZZMXhwNDV6RENlelV0SG9MOTNoWFlZ?=
 =?utf-8?B?d0wvNDBHOFFzYWFmcXJsbXAxS3lhWmJPekpnR2RLVk1OM1hjdXVNMG9KN0VZ?=
 =?utf-8?B?ZzBBTTZnK2s0QXV2enF1TzFBNldMMDJQZmZoL1J0MFlwVTl2K1A0eEZCaGJk?=
 =?utf-8?B?a1E0Yk5yWjRQTFZLV04wZkFOQjk0akZPQm1QdnJlQnRxcEU5WStLMHFzS0dJ?=
 =?utf-8?B?TDVQS01PQi9MTUVHdVZWLzQyUFhIZUovWVN5VHIzZW16MlpZYUsyTktBSENo?=
 =?utf-8?B?aEx2b1I0VFlIeGRsdG5tVU9taUFSazNNbVdua1lTMzdjZ0IwVUk1SzlWMGVE?=
 =?utf-8?B?UTJ4cExXTlBDY1lBZkgwdE1LaVFNbGFKcE5JVytITW1MdUllNXk3WVpkV3k3?=
 =?utf-8?B?MFU1Smk5OHF2UkVBQXVwREpEamNVMDExZk84RjBqb3QwblpVMW5wQUo3NU5h?=
 =?utf-8?B?T0p4QUdXTEdtOWM1eEN5TTZ1dS9XUXp3aFJyY1V2RWU0cmxGc0xpTFVCVGtn?=
 =?utf-8?B?dnBqbWxUZDBYSjkxam84RThNOEt5ZjBOL21SUUozMjFzTy92dk8zVVRpMCty?=
 =?utf-8?B?Y0hwVURDU05MZHBnc1NPWStIOTA1M1hIdnZWSUtDYjVIVVJVdjI1dno1UWVT?=
 =?utf-8?B?MFY0RlVKVjJUdXZHSlh6VzVCRnp5Qm9vbW5EalJINXZSU2R2cXVVKzJFdC9Y?=
 =?utf-8?B?bG1IUHE3UlV1UXo0Y0N3ZFJDMk5OYjE5UzBLT3cwa2FoU3Yxd2xNREJsQm9y?=
 =?utf-8?B?NjM3bGs4bnFYSjR0bXplTnFnRU05djZXN2JINFV6b3V2MVhLNlRDeWQrM3FY?=
 =?utf-8?B?N09jclpkdUsvYXJRVnFCRnV3V0FIZ1djV1FwYmFKeVhTdUtnZkhGQlRLVlJ4?=
 =?utf-8?B?dU9weDk0ajlUNDVqdWpwL3NBMnNCL3J4VmltaFVTbThlZURxbXpwRGNiT08y?=
 =?utf-8?B?WmhUYjMvL2w2S0tXcmdjdFoxYVRjVmNoVUNWMkdSQ2JZczdxNVF3cUNQK1Fq?=
 =?utf-8?B?SHUrWWtjZFh5ZTlQZnZiUDlIdkJDRkRTMXRHbjFlQnpLN1V4RWxBcjk4SkJN?=
 =?utf-8?B?cjgyY3I3bTdUTHJPV3h2SXpsQk0yNWt2ZEJxTXBVYWxRakR3NGw3dm5OMmdJ?=
 =?utf-8?B?azVDRW41NHNuN2d1OUdBTHR6dUFWM3h2UUJmWVFLUXNCbXN0UDdIRXRzTS9k?=
 =?utf-8?B?dVY2bDhHdjJqZXAvaml6UTdtV3ZPU2pXYnUzaWhpZy9oYmhzeS92ZFI5TWpz?=
 =?utf-8?B?NDRHb2NNaHVuS3c5V0l4ZnU0V2grQ01mQmZBeHowRDB2STVUajBlWFhjWHBs?=
 =?utf-8?B?Y2xyMEpVWjVHek91UFd0dk9md0JiL29HcDVJZDNmUEdDUFd5M0NmaENGQ3Y0?=
 =?utf-8?B?bHZrYlIxOVFkZS9PYVBwTUMzMkV4bHNqQm52SngwMkhrdnlhcTZZeDFWVGpX?=
 =?utf-8?B?cW5hdEVmKzZtZTZsd1RjVXVpN0xnQkRZL3NYTFA2VysyZmluSHE0WVZueDkw?=
 =?utf-8?B?SG1GWlNuMWo4UFI3S3FqeG5PS2Z2b2FOQjdvQzFodWovS09PT0VHM1A4U1VY?=
 =?utf-8?B?c1A0bVN1dDhES3o5NE1sSVJUYVJneGY2aUV2bTY4aHRuVGxmMFJtVTdEVTI3?=
 =?utf-8?B?bExMbENyOERvMnZ5WUZHUnUyWGg1M1hNaUdPMXRVOG9pNDZvbTNONlBCSzVy?=
 =?utf-8?B?S0RCME5ITWdyRFZDTkRvckU1bmN2UUs2L2s4bmpHZEMxcnRyTk55YzFmQVpu?=
 =?utf-8?B?bXRsVlVyNGFZMmJnMGVvb3pVS1VDb2ppR05DSVpXMG1NS3krRzg3cnJMMGZm?=
 =?utf-8?B?QWNyRSs3S09UbTN4L0k3RUp0OTZIVFFyYmNySHRLdlJwSmtLdnlOaXVDTmxN?=
 =?utf-8?B?NkVrSUhZMEhGMlVWL21UMlhGdm8xUkFnSC8vem5LVkFwek5jdkl1OEZ6VzlX?=
 =?utf-8?B?L0grc0lrT0JJYjJXWkxOT3pwVVYzWTV3cW9QQ3VYdWRzSmNXTC9sc1g3Y2pa?=
 =?utf-8?B?QTI0RkJ5YXhUdkJaNVNFUU1GT0h6T2w3U2MyMElhN2hZNmlwSjcrdnV5Ylhn?=
 =?utf-8?B?bEdjZWJ6Zk10OEozQW40ZEk0NVJTSGU3STNHRGtXdTlPbVk5QVdxd0VLU3Q4?=
 =?utf-8?B?MVNKallmTFByUDBmQ1pWUllINnJ5RzdQUFNJT0g0OHY5ZmZtUDFOdjhIMjNa?=
 =?utf-8?B?Sk9sZzBxdjBaMURpNDZEUTFPSEJ0djh1MTJ4b1Y2dTB2UUs2RW9aQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff89b6-a874-4026-2591-08de9fb49830
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:45:13.1449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rz1FyTZQ9d72ZRJERNrZNP/2C7/758czdVHqNEOjAyI0NInKd9PR8Sd8lKpIBWRU4CCOoqHqY6dopwE96JaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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



On 4/16/2026 10:34 PM, Eliot Courtney wrote:
> On Wed Apr 15, 2026 at 9:02 AM JST, Joel Fernandes wrote:
>>
>>
>>> On Apr 14, 2026, at 7:40 PM, Timur Tabi <ttabi@nvidia.com> wrote:
>>>
>>> ﻿On Tue, 2026-04-14 at 20:54 +0900, Eliot Courtney wrote:
>>>> Currently, these are silently overwritten. Instead, error if they appear
>>>> twice in the VBIOS.
>>>
>>> How do you know that there can only be one PCI-AT image or no more than 2 FWSEC images?
>>
>> Also, which GPU is this extra PCI-AT observed on? When I wrote all this code, it was on GA102 and there was only one PCI-AT and 2 FWSEC.
> 
> I think that it doesn't make sense for there to be more than one PCI-AT
> image. I haven't observed any, it's just that the current code will
> silently accept it. I think that we should explicitly define the
> behaviour here - erroring seems the most conservative to me, but other
> behaviours could be take the first or take the last.

My opinion is I don't think it is useful to check for that, but I don't
feel strongly either way. PciAt image type is from the standard PCI BIOS
image format and even if it is overwritten, it will take the last one in
current code afaics.

> This is more of a problem for FWSEC images, because the current code
> will take the first image as `first_fwsec_image` and the last image as
> `second_fwsec_image`, which means that if there are more than two, the
> falcon data offset will actually point to the wrong thing, since the
> code assumes that first and second fwsec image are contiguous for the
> purposes of the offset pointer space.
> 
> AFAICT, nouveau and openrm take the first PCI-AT and FWSEC images, but
> they use the first FWSEC image to adjust the offset and then just
> address directly into the whole VBIOS based on that. To match that
> behaviour I can update this this patch to change the nova behaviour to
> match - i.e. take first two FWSEC and first PCI-AT, instead of the
> current behaviour which is last PCI-AT and first+last FWSEC.

My opinion is I don't see a benefit of changing it to that because
everything including Turing is working with current code. Note that vbios
parsing from nova is also legacy for Blackwell and later where the FSP
handles this. And I'd rather not make non-functional changes and risk
breaking working code.

Speaking of Turing, unless we have already done so, we should test this
series on Turing as well. ISTR, Timur had some corner cases with this area
of code.

Thanks.

