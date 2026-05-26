Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B814CD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F21910E42D;
	Tue, 26 May 2026 01:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ed4TdOsz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B4C10E42D;
 Tue, 26 May 2026 01:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzgmTqQo+wsCCtI4IJfmi7c1PQuRNuK0IBCdhM25IfzM0PDJHxUiG/kVlY05HRnpYXTpM+iu5t+S/f/IU97OQIeapzH/2IzKJms1s77G3cYcdnWfUxNlucOKc4gcpXcQkHBDseUmV1O+eFseUJjJ+VrtTwrQyvJcbsGGNCS2EGNS+bqrMlu5US2EuknKWZytNNkcPkGjh7kDD3oJRaN1TsO0hNMjbH+lr4I0Do0pNDJgYXoP+JHWGSMBSDXrjNYmuy0oiZW0yDouvDH120jTDad0XlUARH/lJWMQtsthroouo+Nkjac8ZZ+1LP2BlWwfK+VZ8xqyKK11tJhBKcLEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA05CUZtv0Gp3Iigt/+jC72mMunJti+seS6xMVTyPxo=;
 b=IB5fhevrWUYGk0zhP0dNd+6U2eI81N5O5ho5MCl/fyeaRtIoJv6L6rGY4ea/7gRcpgwJp5rZz04/dhOejlP0ZyCDJ99CZfuIJqUgE9/x+G97HR1eQcTAYWse71k1Z9SRB71uDYgXDbGBwHxvNtdYpLlcYj6mvPI4YM6nSYdwY6v8L4Khmf7i8fgLkUe1Gy4bFs7L72wr69x0yfjIJ1q3eR8rXFcBiQCR53zYs1NMj3t/HejahwpYTa9xT13A0x7HeYBpF7hm4NXl9dzyIOMw48T4lZk2EjDbnYGgWV2e5eEhm7oQY8h2Xjo4FRiQ+ZmWgrtA/VS4ssGS6I2cCaEFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA05CUZtv0Gp3Iigt/+jC72mMunJti+seS6xMVTyPxo=;
 b=ed4TdOsztMjwEsD7CiQLtE1LQCc5Oo9OvMJJFoKbyjOxImEv69sMJNJMc22nbR2iNiOvAlO2K6biUUnKeenEBkwor8t8HlPSdBzIqgP05AC72naHIybpKajIA3xrtIkedJRq8erq/6zl9uRzVTk6Vd8plOmSC0devlcYcwP9RrfLoRFH/PRtaI04TtbMycIHeuUzBB5ZtsXYVrsWUGXLIhzs4ay+MDlfN2XFHoBUklh05CC36lygNdcvwh6dXRtkf4EUzIUoK6AlxJxZ2ItkzsfP8xSGl8bp23P2sWusmSjqKtrOIdylthI6Rh/3lVI9epHjprFjZumarQABAth+Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:44:03 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:44:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:43:59 +0900
Message-Id: <DIS87IU7T7HV.368MV5178MV7B@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/5] gpu: nova-core: unregister sysmem flush page from Drop
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <ttabi@nvidia.com>, <joelagnelf@nvidia.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525225838.276108-1-dakr@kernel.org>
 <20260525225838.276108-3-dakr@kernel.org>
In-Reply-To: <20260525225838.276108-3-dakr@kernel.org>
X-ClientProxiedBy: TY6PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cdfc24-53db-4196-c003-08debac843d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: k7OX+BOfVDhgG4UKguVfhA1NIxxkLk1EW0upL+Cwnfmfua6tdu18HmAOl2O173W1N/6afKfvkhL+Pu2q4Eb7Tb4YudBtb8gv8VOk7MvsNHAmP6TubJuFUK0dG8YkyyRCI1wp9MsZUqUneE9vCyLa55EodkJ07vbLCJ5dDlecECKtNB6KCNeWWRNcnl72jQxjWtwJLSNtkF8Y8OB7dprN6e6hf6puQQ1WbVnZrIrfaIRoGpb0jRM9X77QECyN7LspihB99FQQkysnF1DTNuuQEALwxg4iPXEHyALPv0f2DYZy/dtyc5kA8YLEXCSN1/dSx9fHd9hdIzIIpGuOgDA8QYITvGIDKFyZMyS+zJDZVm/Yfq747l0xAn9W2Yi1zvsl7aRR5QxXSid8BYUsKSqZZqB0sgS5YQM3zFpIgOKQffPL4WcX5V2q97pkYgDJnu9KWPuTYRFwwvOSzoIKEvfk0MjbCP3223vaoRQlN7VyEtfAaTxgV8lOWBM77w5aTB+X4hdxXYRsRHAvgF8gdgwrz+9VTgFlOrYttYu1GqGHTKjXPrKrF0tObTlTfE28eTkTCoJl/iL8c55sDukoiN7ZPKR1v49DOYVkA/sfTSoa23PWJghjgRcPqERXn877wPlKPworKeFoiWlTL9XxX3dYpcgDEPJx1exc/pDXFD0XOLjEZmRawmkXTMwdlSJg/N0JtUdQtL5Ly/sg3FhxJBDNhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpaTjlhMDNJT05rUE01aGdFazhLZ0lNK2hTb3M2cTgwZUxLQ2J0WlQzL3N5?=
 =?utf-8?B?aHlHZG1lUFRrSGU2VXh5dkJCNm1sbXpGMjFrU0pWSnBzS0xwc0NEQk9pUkVB?=
 =?utf-8?B?TnZXcFBVTTM2azl2eHYwUXVoNDRHTXd6QnZEMWp3N1JlMVloT05NMnlvN3J0?=
 =?utf-8?B?V1pjbXN3RXY2aEowQmRnTGo5RGxucmVuRnpSSkkvVTRwZWExUGoyU1JmS0Iy?=
 =?utf-8?B?U2xFQVp1ZXBjUFdrdlJBK2JPWkdzLzZwelA1UnczWExMSkVoR2tMbndaTlIv?=
 =?utf-8?B?WE9tMjVvR0c0UnBNU3pIakRFUkJzM1Uwc0NyZTRLa2dWQVdZRHJkdGdMbVI5?=
 =?utf-8?B?VVJLVXNBMTZuOXQzYWJWRDZUV1VwRHhoYjk5UFhQMDJ2UEFTNm9Bdm9DYkJp?=
 =?utf-8?B?emFicC8wcEhzazhLNFRYUVRkVjFDbmUrZVVTRytyUk00SFVXN0draE5vQkdM?=
 =?utf-8?B?WS95OFNudFFXRWJFK2svaUt1TDlGKzdSNXc1ellrUUhUYWdyaVRuaXd2R0FL?=
 =?utf-8?B?WnRnd0U0eU4vMWFEOWlnOHhqTWxFT3h3bkxvOE4rZkhyaERaaUJyeWJDK29U?=
 =?utf-8?B?SWZpVmJEQnZ6WDd5QTV5L01RaUtRRkF2aHlqK0xzODdjZ1RFZlc1cUJFY0FU?=
 =?utf-8?B?dzZpYnpGMXV5VVA3anJlY3dvV3JpY09heW9RNGsvellwRjVGWVptWFpzeEFt?=
 =?utf-8?B?WndjQWVmQjlET2JJUzlmQkNXS0k4UXZiUWpLRGZIdU9Kdk40TFpyNFB4K0po?=
 =?utf-8?B?SDR3cDl0bVdNMGtISzhQcDh3R0FmUmo2S2M3eG54bk9iMHFPb2twd05IMUFi?=
 =?utf-8?B?eVp3MXNYdWgyZFl4ZGRZbzVRQUhnTDF0V2dWZlJ2OWFYcEVrVmQrdUp6eXYz?=
 =?utf-8?B?b0kyaXUvOGtab2lVWDJIOXlDU29nc2xOcEc0WXNpdEJkSjVNaml6THB1VVBR?=
 =?utf-8?B?d1ExQ1VUN1AvQkEzSjdFTjdNQ01OaVNFY1RET0JOSmJvR1JEa3dXOWw2RExT?=
 =?utf-8?B?a0pXVzh2b0VUNWxOeWRoc2RUQzBxSGtvY1JSOWxTbkxVZmMveWovVlI5UXBI?=
 =?utf-8?B?L05CL0o4ckpVa2NCWWpFa1AwWGk2SWxVdzZxUGFxMmRGeUlqWit0elF0YlpP?=
 =?utf-8?B?eHBDcWNGbEsvY3c2Qk5hbCtwZ2hhN0JNYVM3SWcwVzZFMG91YWw3ZnM5b1BR?=
 =?utf-8?B?MTV4bzliVlJSV0tiZHdxYi9jTnBJVEh2aENGTEJ4NlcwZURSMHVxRFdIMFRM?=
 =?utf-8?B?dTZYS081YnRKTkxzUzEyWVRMbnQxbWZlZXU5ZzMxVit6QzZERTVsc21qbUpk?=
 =?utf-8?B?c1F0R1BTV3BHN3plRVRuNnM0NDJwbU1RbXdySGk3YmFWSENnSlhNOTdzM1o2?=
 =?utf-8?B?blk3cHdnOUl4VFNkS05pUGZsQ3hYVnd4TFJ3ckM4eVdJOE5yWHVDRVJQMGJ4?=
 =?utf-8?B?OEl4Z3RkamJibTNVcVNHUmdyUEk0WnAvSEF3QitvSzNYVzE5RktNYlhSSTNY?=
 =?utf-8?B?MTFBR2VEZVY4K3ZseUd4UHQyWEtoVHoxZENvTTBPRlJTWVROaUtFM0JtcUw1?=
 =?utf-8?B?SnlkQU5XRUNhWnQxNG9KZmFhakVLV2tYaTJlUzR2aGQ0U2FaUENvSHlKMnB3?=
 =?utf-8?B?Zm8vbFBOQ0xjcUw2UWdTeDd3R0EvZWlWRGVqUXBTQXhTMTJiVGNsVVZWYmdh?=
 =?utf-8?B?Zk1pd0hSSFJ1K0JJVnJrTkVBdGZwdW5pT21IZng3dldBcGpTdjZZK0Z0WnF6?=
 =?utf-8?B?QWpwZG42RzBtVXlJaFdiS2dMYnpIWDRLU2VhckczVlk5NS9GUHVaTnhrTjdv?=
 =?utf-8?B?NXgzTnJMcEVkQTdrU0s5QzRmd0JocFhhTU96TjJZNlhneGJFK2tFcTRMTE9n?=
 =?utf-8?B?UFdSZllOUHB5ckVqUnZRYUNuN0o3c3FFZjFQTk12WThPOTdsamp3WDViVjFE?=
 =?utf-8?B?Rk84QTQxeFNyOFM4Ky9uOWFxaURtcm1NYUVkSko5RWd3MzNOc1ZEMVhXZkh2?=
 =?utf-8?B?MVhrZ0pvdDFXM0RtRjB5TStvemo5eUhLa3pLNTYzZ3MxcDhXMlE3ckMweFBm?=
 =?utf-8?B?K2J0RGlCdm9zTllWMWtTaXlpM1BtRmJKbzF3cjNCRDdHZk5rVUlOSzBtWHJ6?=
 =?utf-8?B?TmJ5WnJsVnRtcUpRbmRFMkVFZXlPcG9vR1VKQkUrTWJXWGtnMHRiSHVDYXFs?=
 =?utf-8?B?Nk5pdFFxQlBKbG52RCtPK0FYODlDOGtCK1BvUFFzUjV6cjB4V2I1bGtiRTRL?=
 =?utf-8?B?VDV4S2x4cWlhUjJQVkFZQ3NiRzN1VkZPQnhsY0huZW16NGxxNjVUd0s0VFlQ?=
 =?utf-8?B?V0w3dUJWMEx6SFFiNEV6ajkwaDMrT1B6OWpNTjR6Z0FQL2VCc1BNcmZaZzg3?=
 =?utf-8?Q?P5Fx3/c6ECP5ZZyawIqf4euI5kDff3Vu2us1wjc0Epbum?=
X-MS-Exchange-AntiSpam-MessageData-1: MBRrtfrY69VTVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cdfc24-53db-4196-c003-08debac843d5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:44:02.8811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrgte+7w7OysRnZQDZ5B5mM4qp1DYG5vykq8HxJWc6VJXtPYgo9FT3EXU8wYG46dpgiiaMMWNsDdbqak6Cwe3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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
> Now that SysmemFlush can borrow the Bar via HRT lifetime, store a
> &'bound Bar0 reference and implement Drop to automatically unregister
> the sysmem flush page. This removes the need for manual unregister()
> calls and the Gpu::unbind() method.
>
> Reported-by: Eliot Courtney <ecourtney@nvidia.com>
> Closes: https://lore.kernel.org/all/20260409-fix-systemflush-v1-1-a1d6c96=
8f17c@nvidia.com/
> Fixes: 6554ad65b589 ("gpu: nova-core: register sysmem flush page")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
