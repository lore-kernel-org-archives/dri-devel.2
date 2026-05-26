Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70978CD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 02:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C85010E182;
	Tue, 26 May 2026 02:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gWB29vWm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB15F10E182;
 Tue, 26 May 2026 02:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtDQpHUajBNdxBZRoi7p+SuITJ3Ba1awLc2uhDzbyWioTeA0MM5FvWBygdwHiMtiujK6KcQbVkf937GuMrNRD0akCJG7WyMGuN5sK4i5b9xhEYA/p/95LETdqoeQl67qM8JBTEufOjBI+gBrxnvoeRig7zwOCT8/TlqvwUfzub7UOJ0K9P2DfWe5+RVNhwte5H+uWceaIwucsij+2F27tBdwiEQQ8ZEpcpXXmkJdZi9pLC06DJ86MpWmOhZAxNkT2gjsmDlFGvQ4gtoFRzC/IIzSHdhN0sTNEGwIOj7uBs0BQ3TI7uQcW0KUMQiNfusPrjfEpnR3rdOR0B5myNBGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk8slQG8l4zl7GJ1IgIVRO+TgzZcixQ+iRJEfcY35vA=;
 b=llje9NkUzmlZuAj1O6utEjHlSQE4ZQVn2Bbd4EtfRVc6DZg404NGeE7yIIT0hOO4RKGrEJ3PbNcsZ4O8o8lfh/0OSoBQ/LfUcaS1zCF3bP38J4ItRccTf0FKgmCT6l8GYsMONeAcmZhjovtnWMD43InemjXqUHF18fPSofUX6G7fI0X+Tez2SUV/75nSM9ArSlxLY4FW7rRqCgqghULKiOJQig01/RBuURK70kDCh4QsuL5ej8bvLBbxPF7zJgA7ovnWuy9JdTed0pR5a4KsfcWjW8ndLD8mZ2HE+VIAEF2O9YHZU/jE6BxpJeTiL8LM4nS1KmlkcRPJ47rv4bdlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk8slQG8l4zl7GJ1IgIVRO+TgzZcixQ+iRJEfcY35vA=;
 b=gWB29vWmzokypvudjEPwwiZfVVEl4GXAixvALbKbOv2MKXfUW8ie3Y6SEauK5wwcT61gnmgo/eqFhQxmFpL6vknUd6N7pr1ifFpeHhi2xBlA0vOJoN0fUx99kTyDqTw042kcXSp42U+YcIwnejI6SAOXCha1io0fxsYIkTYPw/di9jwy4kORmvBLANJY18hqqjvgHz4+AH+LgBGE2NcbzDKfuSQdZ3g+sjjOG97yhzgSrEt1sHPgGqDNZsV9NMpR4soYCZQbYWcq/hMl7Uzl+waLqRGHuDgMQa99tg5Rphl+NJYRWwq1h1oPN0YbFtBqRJLD4E7X6eYO5apLCAevHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 26 May
 2026 02:06:49 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 02:06:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 11:06:44 +0900
Message-Id: <DIS8OXWMPM0G.3IXQO7RJ2463T@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] gpu: nova-core: use lifetime for Bar
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <ttabi@nvidia.com>, <joelagnelf@nvidia.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525225838.276108-1-dakr@kernel.org>
 <20260525225838.276108-2-dakr@kernel.org>
In-Reply-To: <20260525225838.276108-2-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 696e38fe-3069-4601-8eb0-08debacb7198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 05QCS4rYhosHUdT3A486F7imtaj+6jmRicwWuC7l1v2PNMAby/RsaMr21huW/8DjjBjrTnBgPOLPG4w3kDTcfcy8LZYWp6Uk/piXzBoAdUdmiv2BDwNyVS9dMNYPZ6W/18ZCPozltS8ZSp8IGi8s4SCAVsIxINQCowy6z3OpMzPbYpnoiJgY4ZzDRtesiomyZKg1RzlWMkw7+NwV6Hef2qSoi0R/Y87sXbHlXdZ6+2VC1O/Jvg1MlcB6R6Ij2ccdyvHIZTcc/V2livWqmS7iLWkl/LnTYzs8cfWC2LewK/k39/jF7PW5n+UbOSD6a/7rVvB9n1pHloI0Nl3XavqeWIdiSNyqfGUZ1yAWMhtrF8UNu+DvX+cVempy375fcdq+ubRxVi1YExKFsIIqf/DNmkFBl99qeVjzHNCDqht8KbWP92hlfOwGz9Aquk7+4ZoEZD2jXBi6JncCx3s3J3fkLV3FDlhIAPNHKEcvVZTiU5+mlpBEM4leMG4CKWhKDCIvmECNngc8IKtaqS7uVlYLY/vNz1psDIIe/Mq6UGB7g1lz1TplS+PwGqSnon4NbdqcOS6LWHBD1X5VSqVmAr8dUVBI7kaj9ePaPYXaq4UT0HoPHfK058QQLlGQ9MMpBUXUfq6APMdmmtebc2W6mEx9H5SwzbeaINIkA2iJHnTxgnY4cuVfwyK6zSwBJ6dWkzLk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUl6NlRuMFBFd3NVSWdoZWk5QWsvN01sdUFlU28yN1lBSWhDbkwzOVB4RFdz?=
 =?utf-8?B?T3l1RWZHa0hubUZOd2t3ZmZkSkpPc3FISUtmYWVZcDJIVHdrTkVhZ1N2WU9S?=
 =?utf-8?B?MnNWM3Nqa2VSL3RNSDdjU2ZGUXo1dXFTMWtoT05ROWo4QUt3NnVWRDk1T2sz?=
 =?utf-8?B?eEh0cUduTnFGQno2QnBZUnVhRysrYlBMRDAxSHR4UnBrUUlUaStQZnBaWDZT?=
 =?utf-8?B?RFQ2YmJrakhoNUJYejdzRUFwRkFkazJicVB5RDhrb0pFSmxGZGVRWmM5NytI?=
 =?utf-8?B?NzR0MUc1WHgvUFdPM1AwR2dOR3AyajA5bms3ZlZ2RmFsTGF2VjN4S2pMQlBT?=
 =?utf-8?B?QWx4U3VSdTh2TWZoUUVFMFRRZlBPZE5aL3JJdmJRQ25LRWgzM3FUTEY4UzA2?=
 =?utf-8?B?VnllYkc2WExZRy9oYkhkUmV6SzlCY0pyMHdQRkgxKy9sOW94SXhId0x6YU05?=
 =?utf-8?B?ZkptMk1NM1hMdVpDbGZuK25RQzlnK01jcGpuYmdiOGRpVjcvZ2VXZklWdFJM?=
 =?utf-8?B?UFRRcUdSMzRmUWxOblE4Zi9ESHc2OHNnNjExTCsxRy82b1dGd1pJck4zb0x1?=
 =?utf-8?B?ZDlGaTg3MXNlVW5PQnJvaENzNUpzVkVOVnJ3M0lRN3ZKMDNCQ0MwemtpZ3ZL?=
 =?utf-8?B?WW43NmtUcjRaNEdhQVpmdWZTSHlTQUY4aFg3aVNiZXlhemV1S2F1TGVOVWNp?=
 =?utf-8?B?ZmQ4eWMvOVhMUEx0TVhIckhtbW54V0NvTkE5cW5oZkNNTW0wMlpIOFVBcnkw?=
 =?utf-8?B?b05yeVR5WVZLN2krLzBtZWx3aGZSRHo3eGgxWENtYVJDazU2Y1lNUEZmd1Rz?=
 =?utf-8?B?cTZoOEUwMlJ4dUhoTFhPVjN6eGtCMktKVURMRjRCazdWcEIwZSt6Y1VMZ0pU?=
 =?utf-8?B?Yk5TS2hSLzFXOGg2ZUtNQmxLbEpGejd6aUJFeEtYZ2hlVmNUVEJGQjB0dUla?=
 =?utf-8?B?LzhlejhPUG50dlg0WElCQWE2ZFpPdkJKcElSRldtVHlGSjdFSXZ4elZzR3RM?=
 =?utf-8?B?NWthM0c4VWJOVnlPMklIVlRlMExhNVdab1R0bldza2R2OGdOVjliN21aWG5z?=
 =?utf-8?B?UFE4WnBSaHVJNXFiYnR5cmNpUkZHSDF3Q3lXaFphRmN0YllVZlRZcXRHWnow?=
 =?utf-8?B?bW9nUmwwRlRhT0tXNUh2UzhlYWkrRUw0bXJpNHd6VWhRdWx1bmpZQVIvUi9B?=
 =?utf-8?B?U1ovaUFPSHhpQUdna3EwNytNUlJiOTNLQkw1TjhBeEdBUDFiTVV3V1BhV1lO?=
 =?utf-8?B?TVNac3IyK3BDL1lDblMzNkRpZXJKVVczWkxoeVNoRDhxTFVPMGxicVVpcnV5?=
 =?utf-8?B?d204ZmVXV1Uwc1M3SDFia3BnaDQrYmVEd0Jrc1h0TWM4cG1HVlYvUTQrR3VD?=
 =?utf-8?B?R2JXelJYbndHVy9uZVhBZ2UzMGY1bVZKZjJmcTdHd0NYSTM3QjdleUc4S2U0?=
 =?utf-8?B?VktyOWRBMGFocDIzaXgxVFNkN2VyWEVlSllxMGU5K0lud0R6NFh4SDRFZkxM?=
 =?utf-8?B?ZDRaWGdIYm1ZV3U3cXNMQUR1WXo1cUpBRFM3OTdkY0hWcDlTQ2YrNkRHOFRP?=
 =?utf-8?B?TWdOVHZWMU1ldUErd285MkNkYUNjblJpT01aQnhxWWdDMllXQUM5MjZmcU11?=
 =?utf-8?B?aDJmV0pLL21LKzE4VVFvY0ZuQWkvR3BaZ3VxQ3VrZGpRS21XWUY4MUcxMm1w?=
 =?utf-8?B?a0hlNnMweU1Kb2d0QTdQdnF3bzNMdVdMRUczbm5MdlFNUkRNOStOYWtqOHpT?=
 =?utf-8?B?RG02eGl4TmRXU3BDWDBnR1pxbDAvekpIbUU4VjBuamhyOGlRc005Zkg3SUQr?=
 =?utf-8?B?RkQ0MHo0QzM2ZlVHRVhKLy9oeVVicjE0UDhhWmFuNFQyRitIZnJoK3lwcG9Y?=
 =?utf-8?B?bm9leTVaRlZCNDFaeVBwdlczNkxSbGxlRkxVNzd5cUJqQWgvc3ExNlIyWllI?=
 =?utf-8?B?MHdGdlVlMXdZTDZoSFcvWDBHSC9qMUpNU0hFYnpNcytLL3U5VmxBYXpaZ2Fu?=
 =?utf-8?B?TWp4NHhKb2hUaDlkZUMvVzJGUkEwMU9YWGhkK0Rlbzg4TFpiemNwR3I1WEx5?=
 =?utf-8?B?blhTb1lBUWI1c0xxbmdBUHEzYkdPYktpZVMrbkdMQ3E3eXhaT3lMNUdTL29z?=
 =?utf-8?B?RWZwWmhQT3FNTG1oeVFBR1FvN0VZZ2M2VWZSV3ppTmR0Wm83ZWh5Ty81U1Vh?=
 =?utf-8?B?RHNRSE1zNk9tK0k3emFTc1huVkpUcHRzb1BPbGFNWkowZ041b3BhWHVFOU5M?=
 =?utf-8?B?eXYrelJVVWpBdUt2L2hjbFBTb2ZSSjg1Qll4SXZHVmpQWm1qZXNqZXd1RWxq?=
 =?utf-8?B?VTh6R1pqN09mTmJibE5CYTVlV1R4UmZTcGxtNXJNRDd3VTRLWWJyNHpvTEZy?=
 =?utf-8?Q?/IeZuy7hxKibrKqLiadMXNQ+/oqkvk7uktXdP8vDT0Vns?=
X-MS-Exchange-AntiSpam-MessageData-1: LK6RGVf+/cfS1Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696e38fe-3069-4601-8eb0-08debacb7198
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:06:49.4054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmu1ULCFyXTN7+07NDvNvhOyOfU1ZdFD5Y3K42ekrnUcC5NA/Tz5kACvFCRALGLzme5yTozDXM7TMUY6MpJzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
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

On Tue May 26, 2026 at 7:58 AM JST, Danilo Krummrich wrote:
> Take advantage of the lifetime-parameterized pci::Bar<'bound> to hold
> the BAR mapping directly in NovaCore<'bound>, and pass a borrowed
> reference to Gpu<'bound>.
>
> This eliminates the Arc<Devres<Bar0>> indirection, removes runtime
> revocation checks for BAR access, and simplifies Gpu::unbind().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
