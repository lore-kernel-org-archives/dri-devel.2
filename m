Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AB7F53D70
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1F810E3C2;
	Mon, 16 Mar 2026 16:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGtg5s5/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4B810E3C2;
 Mon, 16 Mar 2026 16:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY+6sKWPdpqJ+65XAe6YycHSC8XV49O/ZhJRaUXEnpqFD8D4xOmUEsjhzA0vNfhRcZCQaOquRLoQx4KEoBK8s3uP1QdKzMnA9e6VzAy6OIoNkpm2Sikdv/5qK0aGa9055b3Vo63TDUJ/jjwUN27n4JlY3e4F6Ac0ZZyj2AiRezYGk8VY9Z0gZrW682wXriwvNvt3Z5xEflN7VIvJwXuW0nZiNIBYQ2vxzpaNXHB/vXltUd1a40Q6fyNKVprgqyTiWNTc/gGyJbsrhKzF2p8cUkEibVKQS9yFniCxNdxhQVMT/AzcObliofiHtURo4BM9jzpSGCOvfTte/QgLyjQ1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJHmgpLiqOXgVSxZtp7KlyNtAgA/FZjqIQ7ZF/6n4+E=;
 b=FG0eSxXvKSyo2dCLWE5fr85qs8Ae+XEZWEdTdiBsSb+e4yspZsAedV0S+mA2RoVP99awnMHTBlB78YdHEd13/pLZ0wTPUaYRSPgh3t3D7G4mGTGexEgze+Rfrco1jJWv44hh2PTaNy/4qcHb2F95dBG5cJRj9dfxu5xq8KuO3cOAiQlYUJMkgl0LQlFP3rj0HnT3Pc/ASq6zR0rUm8RKZiGArKGbamm1lbzmJ1kSgPtKdSylCbHuEFk6tyII7hWEOt6uhAF3fhKec7Gyjry8jn8oqF4MSeRYej7eWpbiO2n41AGAZGOuXCmB94NjMl7x4M2QDfeW8GYWw8Wq23pzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJHmgpLiqOXgVSxZtp7KlyNtAgA/FZjqIQ7ZF/6n4+E=;
 b=jGtg5s5/sAlJ0Vf8U7B7gI4TiV57ePTDpcMemzO1mxPf8b3JwAsoIl4LXd1IN0q0fCHm3gWhoebjlv8Z6jNhCgASMA6E9PagV+UUITEj04e/t9FquiwamnLR1zow9/0wQ1V5IdE8fw1c6dIRE6IhnEWBTTeAcC3puLQkwvBGK7yCnSP59SWvItC54ZuAj/OJ9TPn05pBKxF76Nqk8a4/O1FUQr9QrzRYxJJn7jxbgCBQtJixrIQIXg1XtakqqJX1hv9wni6h+eyjZxDo09htANejXaxTQaFLZadjegJ9Egq5mLMTPba1P2HCqSD5g2TyzsNRGEarUDHFqZkNK3665Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 16:28:44 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 16:28:44 +0000
Message-ID: <891c342d-cdab-4f34-894f-08ead2df75d2@nvidia.com>
Date: Mon, 16 Mar 2026 12:28:42 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v9 01/23] gpu: nova-core: Select GPU_BUDDY for VRAM
 allocation
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Nikola Djukic <ndjukic@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260311004008.2208806-2-joelagnelf@nvidia.com>
 <DH48HM5HOGA7.1EUAD2NXQ7PC4@nvidia.com>
Content-Language: en-US
In-Reply-To: <DH48HM5HOGA7.1EUAD2NXQ7PC4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f9024c-9636-4e9e-7830-08de837917c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DeOf7D3nhDoek2MligFKiGKg58/6BjmvDPM/UwaI5b1fPd06xMplXArDlc5PE6zWzjTAPyeDj0U/oE/avaQMtDCh0jLiziRXEkvzhJNlIp/OVT6d/kMZcPt3dlG9XeLEB3Zrulr1AqAHewI3jHN/RJucRoE/h+2o/UVBGdFK3PVYAGA3rwFSPaX9kPCylJ2BwJQaFqVBNabRKT50cdvs8mPaAn4hoUkltW2Rocr6bZ6u8Hky6pJLDOLtXEB6R647DT6xbcEbOHPbaFgt3ZKHa83MIpfxvhxPvqgLcqxnzKf6uwOFSk41cAnBY5T0/Plr3PbVvgSuLTGSDg42cRPw+AHCcoZ43+KXaYWeb+ZDyh/DwK5c2dYMrJaG6Qkx9Ebiw1AWBUt5QFiLQ9ofQ5CXS8koiO2ZcjqqgrZAgYq99KPWQCn9mygaqdhzyXhHoxyzTopOeQXTEY/zkJvsL9lPCpi3sGkjtcbr2kwAKbaAapjarmFo0GI9jYe+ydvZsOsH7EFibdS3OS0+6qIvTZegZNTAH6dxQDyr8brCWawmJZ+Gf5oYBCJ7esw3RGACDA1M5+pHcBn/GmNdOatUZ4XHtXP0SVhl/1gBO1RPF/xRTY4SgidxzjRYvfpgbgGeIbdbVGQ7rXGppytvmicCSh5aB8rZulODK6QYEo8q98Timiu+4B2pqIRrU5twziTnUmITPimGNIr4LVc9iCOe+sK7979tPpAEPKBQTB3pTIK+ylk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RktBR1k2SDdRREVReUgwcFk0MEZIOUhRc0M4NDhWWWIvVnB5VlpxQnEyWVB3?=
 =?utf-8?B?OStpNXBLbXZLMEpQM0pYOUhLRm9lYjBXQ2tOaythcERGL25pSy9IdC9IcDB2?=
 =?utf-8?B?L2l5T0Z6VDh0TW5lZXVTWmxJbTRSMGFDOXdsNHhtcDcxQ01ycGhxd3ZIamJF?=
 =?utf-8?B?bW1kNnVSVkZHQXhNVEs3dzVFZGRsVmpDSlpWdHB5ZFpMSGRobkVXdnFodEo4?=
 =?utf-8?B?MlVLcEJZK2t0VUM4NkNWNG1vT1l4MFhad09YUW5qZEFIYmFHM2tTWHFWNTc1?=
 =?utf-8?B?ZHRxS2JzVFNhSEdZWnp6UHBMMXg5cnVlSTNBNExZb3JiL29xdzVlZk10RmJo?=
 =?utf-8?B?TWlYOFVodG5vSWtJakFnSStNOTQ1dm1zdCtqMTlVeUhpTWRJOEpKdUpFaE5m?=
 =?utf-8?B?ckMwbThZTk96czdJSVVMYzdqQXA1bG1EVHNXTm5Ca1hSWWpYQTkwVWxkOFBz?=
 =?utf-8?B?elNxUWFpTUZUK21ucDZITko3WlEvZFVDK1RPRUQ1SFB3SWV5L1lhQTlYK3ZM?=
 =?utf-8?B?VE5xaWVSUXFOTkhqTkZPeW5wNGxvZXNHZCs0WnBsalI1bnRHeEpYZ2tuRFE5?=
 =?utf-8?B?L1lUaTAwZVpJRG9aVmpBblBpQm55MWVLd1lMRS93bVFIcHF4NDIzVFZJbldU?=
 =?utf-8?B?YU9SUkJuWi9zbkpaNi9va3M5cVFVVmhOcEhVT3JBWEcyVkRBQXc5NmwwZXNx?=
 =?utf-8?B?a09nZmRBampVcnMrdFN5SU5ZWFAvYXNJY2pocnlZTll2aDdQUS9jWW1VbU9T?=
 =?utf-8?B?WkN5TW9xTTZtMUMrMnIrekRUT0JjMU1xNE5FN3Z5SDRVdURzWFcyZmhxVzB2?=
 =?utf-8?B?OGpic3d1ZmRTVEI2M0E0ZUFLSDJpS3c2S1YrZEVFUVh1RHkxTTJUWXRqR3Ri?=
 =?utf-8?B?N0JPRjFuWlZ4VGpUZ0tUU1JmVmtpdlNaTkdIWlZNdmkxVzZZU2huY20zK3Ir?=
 =?utf-8?B?Q3Q5WFRWU242K0s4LytYbTBkZG9lakFiT0dqS0UrUktFSDZ4QWdvVmtGKys3?=
 =?utf-8?B?alVlbExwWlMyUmY4bFlTNjM5N3JnblFGcXpiR1NGd2ZtbG9CNTdVbUJHWUlq?=
 =?utf-8?B?Z2lQTTViSVR3WHFXdWJRUlcxMmVFY1pIU0FQdi9hR3R5d3JCM0RLVGpLTzh4?=
 =?utf-8?B?OU53TVJqTUFscTB2RWNqUkNWdWcxYVlIRHR0cU55YkJmem84SU9VbmFIWVZ1?=
 =?utf-8?B?TXhJQ2svc2RRYWlSV1ROSE5yVEhQMjBoeTlzNGxrdmtIcitudE9xSi93MnIz?=
 =?utf-8?B?dGVjcW9sVnM1aTBrVStSSjQrYkQwZ2hDMStsdHFRZzRTR1BsODExSXJYcVJW?=
 =?utf-8?B?ekxBM1pQZzZIbzVQcnFhQXA5RmJBeVpmbm5aMzVWVzB0RWpqT0RLb3Z2YUoy?=
 =?utf-8?B?NEpKcll5K3FQWS9FaDEyNDdCYXNGR1BWazZjRFRVZHE2ZlhTaGt3Q1NHRHdO?=
 =?utf-8?B?WW5ZNlBVMGVycnhxRi9aOGs5bHliV0VsTWpXY21nVlBsZDh6V21kYlU4L0I5?=
 =?utf-8?B?RWpNeS8rOEJvOXVrTERoZVNXU09PNkNRdTQ0OW5naktFLzZuSXFWSlh2bDls?=
 =?utf-8?B?ZytkN3pzaTZqWVFDS05jQjJFaCtDSm9QWnJSTnNPQ01KT3Y5Mm5vbkM5ZFRv?=
 =?utf-8?B?cSt3b25iR0dia1VIQy9CTWJjMGduamVkaFEwV2pnYU15VDdQWFRaMlZtSkYz?=
 =?utf-8?B?OU5YU0RTYUxscCtRalJXaEpZV0o3amlIek1RSHAwVmk2ZnJHUlhhaWpWdmts?=
 =?utf-8?B?ZWRJRUdaZkJTdVJFVUlvWDk0RlJTVUtMdlkvS2FpelprZVIrNTN2MGtXU3Ay?=
 =?utf-8?B?NGE2Mjlra1R5SGtoaDl3VitYazdEYUFtcDdPNzRsbVVyVlNzMkRCelNuWklx?=
 =?utf-8?B?UW96cUt6ZWRoZlRLMks1a3pFTWp6MWliRnRuZnJYYUlyWTliWUJQYjBUUjRZ?=
 =?utf-8?B?SVoraHBLUGhnRXlldlk0ZkdiWmttbG12cXc5bHNwRWdzaUlvVlZlM29uSUNU?=
 =?utf-8?B?U2tSVWtsVVNsWm9aaURvdUdPNUt0TWozbEJVRDd0SVh4YldIK0JwSklablhm?=
 =?utf-8?B?cFBSSTJxTWZoSjcwdTRWczVja2lvTmFpQlZTOWtCQWhUYWkxWUEzVGlpS0tH?=
 =?utf-8?B?cDBHNnMrZHdwU1Y5YzB3dkJRcHZUdWVkMXp5RWNDWXE0T1pncENFNFVGSG5U?=
 =?utf-8?B?UjFySENFSEg0OG43VStBL0FHdVEybHlUeXNsS0V0azRDcitQbGVURkpLbUVR?=
 =?utf-8?B?dklGNDVuRGVRYzE5WjRkWlFackNoejRZWnYzaEJGeXZJdFUxeXBzbC9nWHB1?=
 =?utf-8?B?MkdKRWdNYlh0MnFobUVWdmFseEtnZWJRb1RVaEZWTUJGeEcrWHdGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f9024c-9636-4e9e-7830-08de837917c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:28:44.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcA3QjCdo9i9ShzumvQODgSIZ6mOVbMjemumqXnjctF9CUWwFTFcAcMwlDQSBZK2Q/aKjD6ft1q3b8t/kSavKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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

On Mon, 16 Mar 2026, Alexandre Courbot wrote:
> As I said in v8, let's squash this change with the first commit that
> actually makes use of GPU_BUDDY.

Will do. The first commit actually using GPU_BUDDY is "Add GpuMm
centralized memory manager", so I'll squash this Kconfig select into
that commit in v10.

thanks,

--
Joel Fernandes
