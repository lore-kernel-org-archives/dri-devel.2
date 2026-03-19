Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543E91088E58
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 01:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5ACB10E7E6;
	Thu, 19 Mar 2026 01:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FH3d9VIp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D758110E7E6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 01:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaD3GPy5h6Ld/1TdaYOFQ1OaWVGOP9M8Mox72b16jN+2pTiw84nA/ltx+NUxlxfPqhFSkP/tN2075ouTig6v3zSza1kvRHcy2llkhKTVDo8w1uotaHW9bSsQbzcdJTlgueuVElzLD3FmRmEvsGyjmSztF6M5GcsHJWnNDAWt5vfuoXo9OLnCQdKrYGadUcjcUiuduYKiq3wX6aH1Vtxn5Odn6kWZykkWnzMGDl3klerOh1L1XppfuI51wac5KFBPVfcHprEsTDfREGkgz0lLj6NaXAGvlWS865iZfSbKqif56JNjn4G3Vu/IVyBdVun5TR0zlAeCh2LBnboSm0vm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmPkFQ8ill+n2cd+v7v4voLzQmTMZXtBZeICvuWgEu8=;
 b=iauWIJjLQr6KBLn3BlUq/eJ4uMIfO+Mvp2w4lby8+P/4mYxb9fWFtPqUVTTO/Qd+ShDunS2Yybbq9ezof7VmmNYNMvKSEwQkIh5ctw0xfwVButiGGOg41DcYMG84+4oe61hncxCGSksSNFJzRxNUaPuHnkNdPKPkYUd5TYucNkTX3+NV0IXMMrRwIV2yQBj071O5C+NZBwhwh1vjRri92gLF/I0WS51rUZsz96ZvVJXZUVo3kIlOeTKWAtoneMqWbV8FEuDANqgdqlEdEMrqE53oxTF27NAIORNBT9XHkUCuYNUvGuoRh27Vw9y7meJw+nghKomeNOkQI/r/Xx3dwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmPkFQ8ill+n2cd+v7v4voLzQmTMZXtBZeICvuWgEu8=;
 b=FH3d9VIpAj8mj0T7rncA6sJfvMlH3xyBvpOxiivwR6GQWIVBfePOJ7xVFIYxceIPFeZkZ5ZkJf4YcF1OOonqNZaYqsKIFfCfCe4uuhhlRxLPHUmRdugM+T9fi8HE2RlLkpGf7tFIzYj3Twiie6vuD32hZmcLlGXApE1pcjfbvnKtwpJ7ZHzuPtoJFm32DMmOq3jwntbhVxy4noGty18n1Ruc5GBGt43GATafsshrb20lnSEiQW2ETVJrqDQcEOz42KKbLqTIUBiIssNeg1cPdC8bSLdfgaQ0mhYb7EG1NnWKihEAGDljk47bSKBczoaL42i7KK8tH0T2hM03PB5S9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 01:43:08 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 01:43:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 10:43:04 +0900
Message-Id: <DH6DLS6C8NCE.3IGJD625NGHUB@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/8] gpu: nova-core: convert PBUS registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-2-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-2-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a18fc6-982d-4885-e944-08de8558df46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: zkA9WI8h2zd64A2b01JW9DtpVguLBRHm3VQ47uCThElkch6nznxayAUYFqWRZgsqrBhJh4Y1ddudYKpI5GaDIPVb6cwLmJDSSeoC3zOndjbYgdZLMDxeMLs6++TxlPeyKS0EuulmrzPpRPNIlHEQ8DAe/rj2LjxhgtAX6y4JlsbBIwMrFg7hN1+RERb+l7ERIENh6Xd+GLu2lMSyRoeAzcS1i4nwdSlgenq9f1BXmpr2f09NKNK0LKTcEnhhnlo+6i04H2288/zCXflwqftdL4+FndMBCKKTwYjThngWn/pUUUaeNnYvvFiBlY+mj+KUkSKrNZKlrotlRxkMLz2KPR/FzA5jDPEy5E8G9YZwsOXje7Te+OINfKxtcqyoofX4XaOtso1/D/NdQ2O+Oghi+pDgU6FPFWvvA05KZVvukG10J0Mrt7QJQt2oD/+hSE0fHAmzNCxQ/tfMeOrIlbgU0QSQ65uNya/3kWB6XSBPe/iJ2KFRmgASo48DtBs3N46SsPoavfD4uXxYef5TPyfOt9iCPkK8HMEGIDtYOjcZ3qdPiELof04+EN3lFTzqnKsGjp9SlSl/jWbkfSXpprOb+XkNq/Isv7saTY3HRc9pXL/PWB4ASiOnc/YUcJhvOJC3d4qj0NdDlrjAAT5NWVwMkrBSE/mx2i2mnpCIUpnOOCTs3VIuGxY2FgkFfPWfIzcK3LCD7a77TFGF8VEau40I4zKkNnVskKA4hoyQ7EbY+hZMaomEX9kydrLHP1CIfafxgyOO8N/tpz2xK6OPic1v6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VjQnp1NWpJSUtxSjZnUmhFS0JEYkpMRk5iRlF4a24yUzVxcFlabXY0aWNO?=
 =?utf-8?B?YXpoMGR2ZjVMM1dwRFFHcjJpS1VLRkxHNW5melM4dWxqekdmWDNYTSs5T01u?=
 =?utf-8?B?ejRZczNWMjFLdjJUNG1Rd3RPNHY5RmFTU09LbGlLZUNvVm54ZXFxNVY1OXg3?=
 =?utf-8?B?d2syMXB5dnRMa1UyWndYWS9zV2MzRFBwaS9MTSs3WkQ2OFYyT0RjeXJPSjFz?=
 =?utf-8?B?eDlHZVM4MXF4SXZvTFp5dDE5TWFYVUdocTA4dUhXT0ZFMkFpVnZ6SjVQYXU3?=
 =?utf-8?B?czBQcUZWc25MYjczT2Jwa04vOWl2aWZuMmFwbCtBYTEwSldEZmZEdW0vNWpl?=
 =?utf-8?B?TTFId0Nydkd6a3QrUU9pbnY3VkQ4NmJ5MDFTVVpEQ3F0MjdoQmN5RDBRUEdx?=
 =?utf-8?B?a3VkQytzeHV6K01KeHFBMlhDQjJ0ZGxmMzc2VXBXMVF2RTBaQmNJRjlKa0wr?=
 =?utf-8?B?M1NrcEJwV3VwVDBDSFRCRmRXbVZtMjVURzJQcXFudmlQaEMvaFlqNGcwclp5?=
 =?utf-8?B?N29wQ2cvNGtLTTFUODJ0SU1nKytjQThySVptTnl2MlFaTWhJS3gwOEltNUIx?=
 =?utf-8?B?M0xCMXZyd0JrYklBV1AyZGVsOXJUWStIaFRydDB6dEtReStrYk44VTUrMnkx?=
 =?utf-8?B?RnZkc050ZXRraG12U1NnQlp0U3AyelBka1lOaFQvZnRJcEpxa0p6ei8xR2ho?=
 =?utf-8?B?Wm1QQ083bXVaN3l3b0RLVGRoU0ZFWm9wZnZDb2YvQmRDb1N3OS9KSUx5VE9v?=
 =?utf-8?B?YzNES05sOUU2a2tUUU5FbmQrMTY3aW9QUzlsYmhoV2pXb0NYclE2NHRCYWQ5?=
 =?utf-8?B?VkFQb0hhSzBCbFlmZWQ0QWFQV090YTlqeGthOFNWdWNDSVBxdUk3dHBIc0JC?=
 =?utf-8?B?alFJQWVEV2IxUkVCUklOY2dYYXJsbGwyMmc0cVpVelphWGw0NnN3TFVPWk5r?=
 =?utf-8?B?Q0VLcTBTeXVmWnM5UGZtNzZqTWZIZklBNnU3RWwxTGtOdWpITGJCOVlmS2xk?=
 =?utf-8?B?bklBeEdHM2YzK2swTElSdVEyTkhOU2dORVVGdS9hMzh1WWwrQ0pkc1l0Q25z?=
 =?utf-8?B?RE55WVJsa2NYeWVycUEvVnM2dlNOOEZjaVIvaC9ocmtTVURkaDlMS2Exc3JL?=
 =?utf-8?B?bk03b0R1Q3NVN2paamxvdFlNeU8xeFlGSWxlVnYyS2Y2b0VDZ3ZCTEdJeVBq?=
 =?utf-8?B?ZEY4amtHc3J1WXpoNHFJSFJxWGQvN2E1MlZZUy9NUlFjRWI1RXFDS0FBbUlO?=
 =?utf-8?B?TFBFRVZLdVVtc1pzMGUyUjVhdlVxYzA5Z1d5RmRPc2Q3Y2YzM3JScGZqbFFS?=
 =?utf-8?B?K3lMMWhuN3paMHJVblNGa3lCU3d5cm5uN1paUGNXaWR2REZHLzFMZTRxWjRa?=
 =?utf-8?B?d3BIRnNwQ3RNOUY2ZEVReTMwOUhRdnBRamtkN3A1dXpOT0hHOS9JcWdGeUl2?=
 =?utf-8?B?SlM0VTJJU0swOURRTnk4K2d4cHdHV3VnQjB1QlYyTG1LQnZvNjE4Q3VwTU9k?=
 =?utf-8?B?em1TMHBzRmlBcWJGbHdDdjFiZ0Jaei9OaTdVVkxWV0IzU3hjTlgvcnA1OEdN?=
 =?utf-8?B?dExvWVMrSVo5enhUR01WenBwR3E4SHpjY1FNTGdxTnFmODZRclNnMUl3cGZQ?=
 =?utf-8?B?UjFrZWFWcWxxWnlkZHYrN0x4MU5XT3FVVnNrTkdMNDN4SFptejE4ZHRSUXNZ?=
 =?utf-8?B?VEJBcktRY2ZVd0U0enZ0aTBkcEcvSFhrWEc2Z2x1dVlLT3QzMmhBVERobW1t?=
 =?utf-8?B?cXF3alY3Wlg5REdhaU9KWEZKb2FCajgyYTlMNFUzY3RXZDdVd09WV1ZmM2RO?=
 =?utf-8?B?T2VxUkczUGIyMmtwcU43dTlvZkxHL2RLcjJNbDg2THp0aE4vUGZUQVE2aGww?=
 =?utf-8?B?SW96MTNrZ2JIeklXUDIwbDRaU0xQMlVZUm1EdHJVVE5pRFM2T3dmSUpaS2cz?=
 =?utf-8?B?ZzdlMXRkL3FuOXIvTVdjbHA3L0sxS2dETmphRG4wK1U1U1Z6bUN4Y2Ivempk?=
 =?utf-8?B?VzhnUGJtNFJFNTZzRWFxei9DT2RIVlIrYWFuWndSTXRML01nc1lBajhMT2RD?=
 =?utf-8?B?UWJPN3VhdFRubE5sM1Z5R2JtVWdHYjhUczE4OUR2S1N3U3g5MVk3dE42NGNT?=
 =?utf-8?B?VXgraitvNWxUVm1XbXhkcEFLNklMdDBhQlN4RTB0SVp2Rll6OGltUTVtRHd6?=
 =?utf-8?B?ZDVSNCt1M29HcGZRZE5uNHVBQW0vd2E0ODB4YllUVWxNbi9KUjRNT0pHZmp6?=
 =?utf-8?B?dmowVSsxdzIreTI5S2o3VmR1MGp1RkF4b2RhV3RxN0NMdGo4QzdzdncvWWdJ?=
 =?utf-8?B?dVdGZzB1aWFNQVoxamNBVlZEbGlzaldWd2tuS0tsM1JMTnRwdXBzaU9VZGQ4?=
 =?utf-8?Q?lKOLdjLOIGeQJIXmWFLxKRehrwOaLyrKD4DpovUa163+T?=
X-MS-Exchange-AntiSpam-MessageData-1: U/H8KzV58cZX+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a18fc6-982d-4885-e944-08de8558df46
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:43:08.4041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0ZKo6K/EN1Vqv3QuYneifL4BzYZNAT/tXj5WjP3aVUOzezz5aPu6MbgntPvR0yY830w0X7i7RiyHNw2y29sxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> Convert all PBUS registers to use the kernel's register macro and update
> the code accordingly.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
