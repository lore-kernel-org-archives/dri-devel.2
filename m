Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A47FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF28610E244;
	Tue,  5 May 2026 20:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="H0MhAlHs";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021128.outbound.protection.outlook.com [52.101.100.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F003510E46F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2HnpAVpFG5rnrTlqp9MknokJLzw3/rOMxu/Cbqlo9CYmBnPhrdCfcjIfcYmCyCcaaP22qf3VnN+T+ZuRtYJB759GXnx1u+FkYcrtkWVQmPzPBWmClQ7/Bh6znQsgYva3RCtv9WJf9M8qqLcFC7+wbMCXrWwI9mY9xBObUjr3W4LCXijY60nN4FmmL3atXjbxTtyQDT9uA4JYsmEAfm97SJzJwMaMhz8ALRE0c0DRb3p/ycR/b7oCG2ZoSjfobyCIQMJQ/CVQoep5q0igmvRBZQWNfyEy7V6I/zEq3DFi77HETO8gxVuT+wSLpQeGGsowzosSngcnDFcWP1TK4e+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+3g69be+UQL6DAucpBwXrbvze/gEArlSA1tpQO4apc=;
 b=dv9yGok4PJhrGlZhuwrAjvwAGaP6pEuYHZO1QjSvD/F5Fl2BMoU/UScSlC0In4Foy4+JigSqzGIRM3E2d8zPFwl3+JT7dbEC9E0jhExQhupu+sMeiokhoq8D36xrUTeu+Y/CI18B5Ekuc3yVUj+s/g7XWDM3/jdnv9xA4uK/ZFARcUv92vWoh/uUOXLf3ZqHUtAe4XsBVJmAfNRSZo8Txu7d4Tpzg1HgH+NHJVqGZ2urWLVNlyhQ2s0JNZne2WqP6mZdtL9X/0Cr+8+m7KVdpzrnWqVlBPw7wr14I4n09UoGvCcUNKaBuaqAqe1o4S8tmvWA9fjl/O7GQbf2YC+zoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+3g69be+UQL6DAucpBwXrbvze/gEArlSA1tpQO4apc=;
 b=H0MhAlHsOHPKehzADA5dsHkc4CLNzDTDqumWkoaKWy7YtYtblw0vT4dhQGi0OyE+F5wDN1ybwST65tPYNIrcpVMk31NhnhyFRj46mBSXQBVqsv8LCt7SuLwUX3izMgcJYT/sz/FpZxOAGprtH5szk3LcHzc12Q1KLVrMnm7VsG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6238.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 20:06:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 20:06:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 21:06:47 +0100
Message-Id: <DIB0IGF35JE8.2EQQRLEKVWSBW@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] rust: alloc: add Box::zeroed()
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260505152400.3905096-1-dakr@kernel.org>
 <20260505152400.3905096-2-dakr@kernel.org> <afoRXrwKjZAJuMaQ@google.com>
 <DIB0GYCMV121.2VPS75GHH082B@kernel.org>
In-Reply-To: <DIB0GYCMV121.2VPS75GHH082B@kernel.org>
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 1feb7646-61dd-461c-8f73-08deaae1d6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BW/pUtbDFXFmD4nGFTTM/2KaOzXl6dSRQkeqTBlEEGsik2SNMGHQal3O5gWCAC7ti3Mq5D15mhxvAWaB3KzhNUCbhPiLAPKh7YPJFw0m/tSGzObbcskgZoG5NMWXVh/HcfDWHkqSeOd1WR2+ODP/esQbQe1RL+3kinGQy54nxviWMr8V1hUgrbJBT6zyLjS7MQYTt9hPaPCRh4F7syKnERTrvsz6+75sgoOoLDIDZIxxQIY3VvXHY9y7+rLZyNSCMNTm41I1mN1NE0k9bnAGfqMn81NSbh8N7eUle0Oo8LPjSEDx+n4p3voO3xPcchGpyWsRoxyhS0MbWKBPZsATR/sccHYHWt8B7K689/bxQ1gh1r+x5kg2YfcTovYztlSAr7oVk6vBxtwmBYTTMkd0rUjuC1fRO9Gp2L28/TeXmvjHEwIkDHbJzqXSo8YrSTM79t4f+2UX4RWjlOLNj2w42iG+YQsB/3SRGYP6TmO3u7NQIqjoyNikhq96FUIiHlGmbq1Wiat0bFxSC95HjD5Dx6vkDs0f6oJk6NjFCo0eS29AXyV5QwhuaHF/HFdFg3jurjpOT7KzvH45B/THIOZJKony1dBd7wBlphnzJv7kftEJAMJaYWQVHQJPMPzni+06loiyukgKeCCB78VoUkFL+DU7IIqQAFK+ENcP3afXevRxremUyAn6daaYFfK48cDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VxZGFJN0EzcElCc0c5U0ZuaUVGR21zT2RhZkZ3OURBdjhyTWJhZFJZQWtV?=
 =?utf-8?B?RUJjeld3SzhmaGkzemg3RDBaUTVQT2xmMFhQZUJpZHliTXlMcWlPbnlOQUl1?=
 =?utf-8?B?bjhTYjBEVHNyWTBwbHBZVlliOHhqV3JrZDl2T0NpMys3NWtSSDM0RVRWT0t2?=
 =?utf-8?B?Y0lORllPcXptK0NlZzFCL2NuTUJnVjEydEV1ZXMwdmJPaUd5WFE0Y3M0V1FQ?=
 =?utf-8?B?ZlBjMVhtSytncC9xRWNmTzFKZHF4cmRXano5K1ZEd3p2WkJoUU1LSXA5VGtL?=
 =?utf-8?B?ZERKSElxT2VzR01qRzN5U3pDTTFUMy85V0xGdTR4N3U1dDVTcGkrMldza3Z6?=
 =?utf-8?B?RllDUis1cG9CaWZ0YnQzV3hNNFdDaTZwMCszMUxOWDB6YnhjeFFiNEIzV0sy?=
 =?utf-8?B?VWp6TExMTVNqaHhqNzYvQTBMVkZDQ3FyeWNuNVJRUlFmQUdIVGRYbW9aNkov?=
 =?utf-8?B?bkZ2TlkyaUdNa2RSWE1CalQvSDlqYnlrd1hScFR4SFU2MURUM2pBUmllVUVs?=
 =?utf-8?B?V0NsN05mN2o2SUVkMGtYVWlWT3N3dHNvQmV2c0VpWWdzK0p5ZmtLOURhc1RR?=
 =?utf-8?B?WHEvTFJwS3BiWTY5T3BpQWgvZ1pGY0c1Y256ekp6OW5XdElyZjVqZHdOUVR5?=
 =?utf-8?B?UzZrVjJld2haS2kzZWJHcWVTZEYwZngxamFqb0pDNzUvQkZObSsvaU5MendW?=
 =?utf-8?B?VmdzZkhZRU51NzhPVFdyc2VKODJNRDlNMWw0aTVhSGhCemNrR1VRa1g4OVhy?=
 =?utf-8?B?em00OUVEV09YSXdqQldXYXkrVElQWDFCdkNHU1Q3R2RHbUhuZENHNUtQSm1h?=
 =?utf-8?B?L0hnYk9KMDllWWJVa3ZyaGxGS1BsdFJEWlRubkFsV0Fvd2xHUSt3cWtZVFRq?=
 =?utf-8?B?OXFBejV2YVdBd040SmR1MFArUlFaMFlmMW55UHpKb3Jac3VhM2dBZHR3b08w?=
 =?utf-8?B?dU9rTzZuTDFhYUpoV1JjaURmU2haU0M0N2t2QkUvYnI0THdHaWYxSXJ5bk1K?=
 =?utf-8?B?TUxNNHNSRERYQUxqR1p6K1ZTTVc3ZWhJTzhwM2NPekttY0gyWU5VRlc1R3Z0?=
 =?utf-8?B?YlRqamUzQzlxOVlzZW5kOWxPOW10WThkMU4xcnhpODJkcFNDcnVWcnhvNC9t?=
 =?utf-8?B?L0IySkRxSGhjTkJKZ3ZMc0I5dlpOSCtSZkxpQjYyVE9ybm1qQ3pCMGh1eXBw?=
 =?utf-8?B?SldtcFFxSHZEL3NPam04cVcxcGFvK0tEdUwyYndpTnlzRkxVREJRQ0ZLVDJP?=
 =?utf-8?B?dDRRN3hyOVVILzd3NW5BZTFycWZ0SWxaZ2h1VFA2SlNVZ21tK0NYUG9QNWQv?=
 =?utf-8?B?ZnR4UUpyWjJjSVJBVUJTSHVBTHFIeldzN0xFQzZmdDBPeEJpQlpYeTE3QU1u?=
 =?utf-8?B?MFZpMDZ2V2NTd3lZTTZMbVViWi90RkZGSEhQck1KQ1VCZ0xnanp2UlN2anFw?=
 =?utf-8?B?aEx5alduV1BQSGtsWDVUcEUrdWJTa0pzN0JzWk45UmxReDNtWVZzUjlqdHh3?=
 =?utf-8?B?U0ROc1JJZ2xXVGdFd00yVVdKMFpROWJiQVdVQnNleHJEQko5ZTZzRUh4NE9q?=
 =?utf-8?B?cTVyMUpwai9ueXRQdm41TEJreE9jand3Wi9LVkppWmZMdk1iRnV4Um1DZDQ3?=
 =?utf-8?B?RTBZSEFaUTNISWsyVWpBUnZRaHNPQWtEVE9jSDJKT0FnOGYzZnMxejErM24r?=
 =?utf-8?B?T0N4bWd4NDNGaDVlcnJXRThlRVhySENNampkVEJTelhrTTFVTzVhL2IvM1dt?=
 =?utf-8?B?QzlDUHFFa2F4dFFLUWRxVnRiU2FFMFlFdkYxR0g2NEtiRG1mVGdhbHcyQzJm?=
 =?utf-8?B?Y3lWTFU0VVhOTXZjL1FzMHZkUTluRGdZTEthOUUxNlVnQ29OOG15Y3JtM3kr?=
 =?utf-8?B?QUVkcDRxbXJsVzlyZndwazc2VnpLTGJ2WFFjdWhTc0RtcHVyZENzN2FKUmJY?=
 =?utf-8?B?WkpCdHhIZlpFZjZ1am1PcW1ralhjNVBKaG10QTJ5VXFWbXprcDhnekZSZzVv?=
 =?utf-8?B?SHEzeXp6eFdNeXR0ZlFTSUNLMlFtc1ZqWEtvdXdPNWxyanJKaGFtd1NkYXM5?=
 =?utf-8?B?Rm1mdnF3Y2x1dVJKVWFJU3JBZENVVUhsQlArMklUSlNXUk43MnVBR3NFWVhz?=
 =?utf-8?B?U0NYeVFlZm9teDlRMTJWNTdXS0hXUW1wTFVZUTB2ektJSEMzdUV4WFBDM3Nj?=
 =?utf-8?B?VkF4Z2lQaFhMb3h5a24yWGN5bXlFbm41cmpHZDMxTUdCYm8rU0hNUjJKWlI1?=
 =?utf-8?B?eTc5amhyRFBldTRBTVJqU003NEdkaS9hb3Y4Y0ozb3NYM0ZjdzhvejlORk1J?=
 =?utf-8?B?U1B1QWV5UGl0NmVHK1RnSXBQN2hRY3ZmaUYwWTBOd3diRkJtZWh0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feb7646-61dd-461c-8f73-08deaae1d6e5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:06:48.3738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjjmNtpa2t69lZdNIKjsQ7quKafYmN2COltLO8wvKBybxS+hHb26NiVF9hC7HLPEgBJvk1EbXqPsDzD74JOfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6238
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

On Tue May 5, 2026 at 9:04 PM BST, Danilo Krummrich wrote:
> On Tue May 5, 2026 at 5:48 PM CEST, Alice Ryhl wrote:
>> I suspect some of these imports can be removed when you add the prelude.
>
> Yes, but I want to convert the imports separately, so keeping the change
> minimal.

So far we've been asking people to convert import styles whenever imports a=
re
being touched. What's the reason for doing that in this specific case?

Best,
Gary
