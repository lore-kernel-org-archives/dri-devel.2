Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF28DC44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A6A10EBAF;
	Tue,  7 Jul 2026 07:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+o9dhJZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3057510E460
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSWLM5RapURbrDcaBE/bpCs9Yzn296C6VTWRCcSMJEDhvnjnorp7MBqXyM47V2kMebQ4agxQaak7zxZoLEaeJAuN1OMesBkQ+13QlBEuRFgUE18bqTH/P94XOeyMbX7+c5C2dEDCHIV6uaz6r6k4z5O52638X1htUKlm/z3oxvdG8+mZMwMb4mZKZ68AsKgEjYoJVOwKspXiJAFhnwzXwULr020h2KnE9+W/pdSZ+tWbm+jTp0CYT9iN4dbq34y7xjMjZYw1JySiVeEGMDganneQzVOvygnXV5NwCqhRM3mEhYHjuaecglca33gXh37BnZkPEY7mQXzjwI0gR0VMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNrSzlyO8Jtxxc/FWFZ5zW+mlL0cTK1k7hrhwiCdSV0=;
 b=aX6wfaTiRvU4BF/yMZ2O0tS1cR/uEq25rineM4osGp86SDN2rg69BXI3VEXHh7H5EYPLUAPppxXW2lyLPZwIbJ3v+Qq4PoieBqVXszpjwlCUt+DzT8bDbeEuTLl29PnV/KOkWpU224YiaBByRbpTL6IFvsTAwiIXF5M++AK4BxbBh4/ncojDx5m4ZfS74S0LXoZX8aXtj0SCCs9jJ3VPk4endfa7bUASGosaoaLANBXTDGTJfwwhNF/n2uYhwcntzpLmy5QnxKg6ZpVHQKIkqJX9waKaE2oCnZXCQKgk6hwJtIwm+hWoCTXb+Aeyfw/bQwLHzU/RdwqWi+HwANTNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNrSzlyO8Jtxxc/FWFZ5zW+mlL0cTK1k7hrhwiCdSV0=;
 b=G+o9dhJZp39t59cpqp2hONZNjjvB3qrvX2+y9/xdlIAQE3ZDFHiRS824cGywTbuPWakuRx0YXwXBNBEqP7pzt1rDyzaE367e+s3y5SnUrdA9K/5O+r3I6viFYp+3RELoyYJfeF3//driG9ncfHWskI7lEy8YJQ2coOACwItM1deVZNLymOTAba8rJftIZ7GTuvFqnpS23uq2KQpuChfYFRDVax8lQtMgablHOTmJ+g0vq9y6OECvykL3giJhTV5YqqQoQO+w/WebaQbyjyHrU7h/jr2WvQyoUJCY1UPt/mFEAebtjygOpyFUc/717VwuaDIQusLbde+MsExi6lYOcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Tue, 7 Jul
 2026 07:49:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:49:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 16:49:33 +0900
Message-Id: <DJS6AAWKLBF2.1E7FH1HJ3MY2N@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v5 09/13] gpu: nova-core: move GSP firmware files
 decision to GSP HAL
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-9-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-9-ecad9346387f@nvidia.com>
X-ClientProxiedBy: OS3P286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f4::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 847fbdb6-93bc-4621-13d7-08dedbfc4ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|376014|921020|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DOP+5SCwRvMMXBl4mmBGXsom4Cxq9jIz3RIVjM+QwucVN6YwPdH2ax4wlSjYyyLtrsRhM3lLAbocUVahNmssn/xAGDF8HHtnx3HJOhV65yp9otC0ZNqRx2501Ecct2fueBkMhmVniGM/MxNjGxxz2oc4KrrJVQ8yKcBTPTMKiwwlC9uQIxHT6XdwOBp4BeR7s2KWLX9EMvRPXKeggrKe7KMfUISYukKaa6BWQIPzcdEY3+k0loScT5kw8iJHw3qIrtwYyqYaizpnTRXXeQdvjWmccPKzYGaoexwupgYNpiNxW2w1CwWl8gN2H/jXn9+9/7b75RZTApog23LX7NWJN77ggtK2C9zJdHXpnudMFrZTjR+JD2LB9+yRF5WUYPRWFB6SVpWXGQJDH2YEPd+B38+E1DmQ2DzDMcgrwh42Yf9rAXCv+uNNV40gBnGDJBbMBcvERSbYIAfFMXizGdM8TJRIU/jd7jHnPzZVKP8f7RJBkWROCVydpJHGXMq+avpW89PulFvCLTiZ2gGxz1v0dWY6k8l0q96yF4zM+HuER+jSfCl56nQX0kXFO+dpGtEhe72HGJd4gajPtPKZ3Mrsx6hjQrgTXce0DyEazGuekNnvVceGOnX/KhYcPZy5Cw3Ob9AqlC6xFG4aPtQd95f0S2cxwrweXsc9SmKUee3rmhNQVtd09RrxCnH/I6+2IKiWOcb8IirybcNteh5DhLjtjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(921020)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VFak1TM3YxSWNZTnJGZXM0V21JLzFIOHVHZFJhemJCUFZrT042MEc2a0xn?=
 =?utf-8?B?MWpuaFlDcnJMMWM5YmhnY1FSWnNrVCtpSENwQ0NmQkkzSGxwdHgzQ2FaQ2dN?=
 =?utf-8?B?cWhWQkRucnhaWE9kOExxRXZ0MU5lblNUTm14cDlGUGFFNnlqMnV1aFduSmpL?=
 =?utf-8?B?UzdwVGNnUHNrTlMwLytnYUNtS1BJYmdiOExiS0YySnJCdGEvenlpR2RYTUhU?=
 =?utf-8?B?QlBLN3JXTzBVTlBYWVNackFIRnc0RWFyREhBbmxsRThDblNFaXNRN0ZTODlm?=
 =?utf-8?B?TVV3a012YUVYVmdIRVBhUTl0MHd6a0tLS1JjWVNtYmFFWjRPckhscHZJRzRO?=
 =?utf-8?B?YnJzRHc0QUZJU0RTUnNPd0l1dmJyUnd5VWpyeTloZG9yc3QzN3g4OXYvOUFu?=
 =?utf-8?B?R0V4QXdyVXIrZ3R6WHZRS3BrZFBKRFNuYkxWbHBxekJUcU1hWHhVVmk4anMw?=
 =?utf-8?B?bVdHWkllemNIRE1nU1dDaHdMQkJGazkxMDF6NkVRNFY3RDdOekluZXllS2FQ?=
 =?utf-8?B?cjZjL2tWTmRwemRMdjBMSVVjQXVuUExzVVhNRDZCNTFQdzBncjNwUUtiMklI?=
 =?utf-8?B?a2M2OWhUdEhERitvaFZJQTlybmtTdVE2OHNDNTRmK1VZSmQ3WExidHdWYWp5?=
 =?utf-8?B?Yjlad0NnQmllY3ZMNnA5cFF6NDlzN2RLZGpiVWM0YytidEVmQURGUUluaGov?=
 =?utf-8?B?YXlaR01VaFltRmtIbzNzQWtGM0xReC9MVlJqdTNvREFhWkd4Q3FSejJJcFhv?=
 =?utf-8?B?cCt2cnlaSm81cHRTNk1IanN2SHV4cFpMZklaU1FCNHp2Rm42VS93d3FQenRl?=
 =?utf-8?B?SndXUWtFaWhqdVZsb1pTVjZHYVZMZlQySG84TjdMS0FnV3E1NEhpTUJMblJ3?=
 =?utf-8?B?ckh6bVhSUUZPL3JQaEJMWFBRU244NDFGUlhYNnRTelhTcjhoTHlmbnR3N2dH?=
 =?utf-8?B?cWpOME9paXBUeFp4SmlRNGhWZ01vMEprNm5EOWx4MkliRHp6YzBXak8yMVJY?=
 =?utf-8?B?MEtVSndBL1pBa1poOGxVQlpIOUNoejRpeElVb1JUTENMTUVNaXJaVnVOYVVB?=
 =?utf-8?B?a1VWOUYvaEQ3SFRLODdmT0pHZDZsVURacWo0b252TTlzdDlSVDhjWmNsbFk2?=
 =?utf-8?B?cTYrL0k2ZlM1Rnd6SE8wY1o1amtWWi9lVWFPYkI4OGdhcEpzeU56Tnl3RFBH?=
 =?utf-8?B?bmZxb2l0R3ZQZTBkZEkvanFzaGlFdHh4ZEpMcUF4b3N6YmVWdFA1L2lmNkdI?=
 =?utf-8?B?aktkSmttNVBaTHpKT1NhNEUvNThJUUNDbncrbUFwWW9oQVdZWnhkSFgyTDlV?=
 =?utf-8?B?d1EzNTF0Sk9IM0owUmJxNnk1L1ZIbWdKbUs4c3pmOGxNOUVWa0pmNVRjS0Rj?=
 =?utf-8?B?MHc1RjVwdHMwUjEyekk1L1VPWFBqSERDWVZ5QjFrOTVlYVpjaVd2WjJZTFpj?=
 =?utf-8?B?dVVPL3RFMTJEMTBQTFFnd3N5K3pzdkpTNEFRd1htUnp5RXl5aGVGcCt1VzJ5?=
 =?utf-8?B?RGtwV1dwNHg2TEJlZWc1djhXeXg5N21CZjdjVWdVdDk4QUdNbWdxbEh4VWU4?=
 =?utf-8?B?N2ZQLzVjN3RLQU5LNGsxeXF6eTJXNGQ5MzVXRURUTkZFNW1ZUERFMVlHZ1Nj?=
 =?utf-8?B?bjY0Zm5aNkJiQVB4ajBxT2ZRTjJCNWZCYXVyRGppNzcreHMxVWVVTXZyZVo0?=
 =?utf-8?B?STZjbVRQcHRRSGE0eFpVUmxoOXJPbFkxYTZZVkNwKzFyWGc5RDJVTW5vRE96?=
 =?utf-8?B?RTR3dEhIK3l6Y1ByYit0VlVWS0hrQ0JDWUZOeVhQTVJuaDdPNExkYWIzazhp?=
 =?utf-8?B?cVVHcEh5eGIvbDBsSTJva2o0T1VFelpURXF1WEpXODFpaFk3cHRCV2svZ3dE?=
 =?utf-8?B?dVdBckN6YmNySTExcGcvQWdNVFduNW9IOEo5SXlZOGhtQ2JZWnhmVS9WUmg2?=
 =?utf-8?B?MUtSZCtqNzRxWGZlWk9XL2FmTlB1N3Vka0diemwzMi9iRGttNEZod2piUXJM?=
 =?utf-8?B?b2Y2VW94L2dFK3l6WG1WOGVaQlBlR0NZVjZHbVI3TjJzNXRPNzlLTkUyOFUw?=
 =?utf-8?B?NG43cFFvYlpNUm5iNU1qaUJ1VmF4aXdkMm45S1V2SkhvWjQ3a1M2UTZCWW5j?=
 =?utf-8?B?M0UwOG54d3pWUnRBODIzVkZ6YXlkT0RVQzYwMGIvR1d5YVJTZ3F3UWJ5N082?=
 =?utf-8?B?eDFoSkcwcks0b003T01IY0NBTWZXSlNmZ0lyWkprVUU1TzRuOUlsMG96N216?=
 =?utf-8?B?V1hKS1REdVFQZlFNeVdldEZ2am9EQk9rckVwdTRINmdOd083R3AvMjZ6TWtE?=
 =?utf-8?B?UWtqTFJIQ2x0ZkVYRlMxOC9WU2ZkWXVTZndFYXNJQjNhdXpJK1V2YVJsT2g2?=
 =?utf-8?Q?jxrCxGWLGB4TePrXkisIJVj6yOi2C43xQ6nEcLzb5F3mt?=
X-MS-Exchange-AntiSpam-MessageData-1: jYY+MPiiB0DZeg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847fbdb6-93bc-4621-13d7-08dedbfc4ae0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:49:36.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/oJtibe1Qow/DDkfBV6OgniB6YbhvsOOb0ZDW9K/Xh2o0vWhgh94oLfq1XprNpUsNyKgE3SHIGrGbyMUwC1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

On Tue Jul 7, 2026 at 4:21 PM JST, Alexandre Courbot wrote:
> From: Eliot Courtney <ecourtney@nvidia.com>
>
> The files to give the `ModInfoBuilder` depend on the chipset; this is
> HAL information, so move it there. Doing so lets us remove the
> `uses_fsp` and `needs_fwsec_bootloader` ad-hoc methods of `Chipset`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Eliot, I put you as the author of this patch since it is basically the
diff you gave with very minor changes. If it looks ok to you, can you
give your Signed-off-by?

