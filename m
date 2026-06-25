Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCCDCDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44A510F2E4;
	Thu, 25 Jun 2026 14:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="mly3kvo5";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022130.outbound.protection.outlook.com [52.101.101.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A53F10F2E4
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUywfutdB6yx6yg2p0B2MykSTylrRAH1S7m0/NefzQZKgHLNZenlc3ZU9SepOOkP0JlBRHNlfV+MmPhIPgfyvPL7k/vjkkZsSjGAJPDEwBxvsf3dzG7W25pfSXUmvKTPj80JZhbRd5rp2hcAG926Z5w95cxTO97/iehcqghivjr7FMXAjRfazPCO+dhOHVxiO4Q65qk2tPZqfloPNsNWBufLaRbXAjbibRP/cUIrrc3L74OZocpKISFdX3GaXXpotnKwb9Uea+RrYUpQkl34avp9aeW63GgHBXfZAwJbXLypkrLrgE0D68l99jgzlzU503S+OtThyH6wcRDYXbASHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzz+BcOTUAcq8Ub94lZXOeBcMkoRbKq+SOr775JxgQ4=;
 b=QT23p53jLZCxMGsiOaScojjr3u95iU0PzlOGs1gvt92ngmEPf9g3H7KSHIiynnP6ONtOb0nfU+9tFV9dK+h0wziAkWhln+iJlACdu6UyQ23ZhrcO1JiwikZ2kiCbR7dWYXfA7kJ71/4wLtvVoy/oGYneyNSF+k1FiccWH9doSDza7xnIGfaaRrcazOPIVJpK0GRqqgjv1dm4cznbCts3JdVXC4YYkbChS2FraVqSH6Ui3V/z2aGhHaI70wjC/n5oaQ7DczLkuNjLQbCetVSyFEDTjis893Guj8Sl2sjf/nUotIM6Z2CFeGtdrGId1X4XLkikatPW4xZIMdyot+Ojsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzz+BcOTUAcq8Ub94lZXOeBcMkoRbKq+SOr775JxgQ4=;
 b=mly3kvo5udW67NLf5ML88AzNmWwGFHttpe6mkn9x1XYofzdgGxmqjWZ0fdlVk9ZJHmNaJg1ua/aiow9nfy4SfjPWXltzFoYOsZ1kTtM0fxDw0Ix2XX+TPaIwTJqKG16jnTVq78oFEjRBZ3aA4Rwur09nAIeYInB5npH69Nu30EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8336.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 14:28:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:28:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:28:25 +0100
Message-Id: <DJI79647HWWE.KB8MPP402C4B@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] rust: auxiliary: sample: demonstrate ForLt with
 invariant Mutex type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <iweiny@kernel.org>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-5-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-5-dakr@kernel.org>
X-ClientProxiedBy: LO4P302CA0007.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3926f4e3-11cd-412e-b43c-08ded2c60514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|7416014|366016|921020|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: NTSkEPpe335MS6sK+Jo3UjgN6paD1uGmZhzXI0JHadngHvoK7oDJTX7OphAD9VAkfVEnJ6Wji/7Jq7TpvkUSmSyTcCUtrR7IoGFIdIFtq8yL39wowv2h8KalxyGEKNDxRmyk/eMF57J5ho4rh/vUc0bATn4GhEDcdXWOjnevRGiKC2c4t8Ag3EtCb22kgt+QfmSgZc89oW8SYpiqQolJGusOAgD1gsHD4Fqh1lVQ0EvgnDyWX7YVX+/2sdL7stuQ74+lQMPvZMvAEtla3Kv+W+0P3Q/OM33l7eJJdBJW+Ri33xgV4AkWswmQlNWURLmulvnXwPEbRJqvBmju96xN/g9Ys7Gc6k/lL4UmyzQCOIpbteSTEBemii9a2w77dG0OwCxdI1M0b09caQ+q5EPboQ5boERjLM5kfTKyt0TrZ5qt+TqOnYkOTd68F+yWl0FLPV/ET0xOOu5p13iO9uIx1Yk4XwhShHekw/EhiYc5p7j+KUj1Dsoi6me4z5HB+8sQIG7VcwsUr7AQMiOXkrJ7pCHYZ9EyFWFEgYdn/ZCRbNBDbRSfAPjoxQmvPqSh1O2ri6cVJNikN9oeDc4eJyXjlDmOA3V8GovLs2LzUr4FXfiLSYww8klDFwzZaIat52IcPFEj9p+tzTD0om1OkNYjQYCFhgneGYZCvX2Ir1uCBf9OHhOvXuOcKTlOkYqUAx/Ire1/zPGR3Denpm4YOItEdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVIZ0ZnWThITUJpUUFZczQ1YzczUU53RW9BM1ltc21rekNZajNFZ1MrL2xU?=
 =?utf-8?B?RjgzdytTQitUbmU1RGlHTmN4QnB5S1VWRVI3RUQ2c0x4K2EvaUpjdTJaOGFM?=
 =?utf-8?B?Q1pzeTBmYWUwNWtCbUllaGYwUzhna0VCZitIVE5uSXFVYXh0WkFRZUk0aHFx?=
 =?utf-8?B?ZExvRmpFWlErUjdjMzBpN3ZDczNwTlduME9SN21uZ2FCUHFMZ0RuRmZ3dzFl?=
 =?utf-8?B?UnVjSGRtc1pEV1dFaHdmaEhWMXBFajlHQk1UQTB1dkRiUnJ3RXFieGxZZWJR?=
 =?utf-8?B?Q1FpQkxCMG1WR25ZdUV6OWNSUUVsVmU3SVF4WTNuNzdwSmRvb0ZzYVlSbWY5?=
 =?utf-8?B?TFRmRWRhZ1hpSFM2c2NRZjNMNjBiVFBxRTM4eEMxcUl3YUlUeldUYURCZHR1?=
 =?utf-8?B?anVHZHJRM1Y1V2tvUHdBRi96d004dHZFKzJuV3N1aGFLUG9rVFhqT3hlM2Jl?=
 =?utf-8?B?U1k3elV5aTBKWlJaVmJBZllPSWs5dTdmZ1BrZW9sTE9Id2VNVDI4eXlmeXVk?=
 =?utf-8?B?L0U2VHJ0YlE1dUdOOWhNMkFrLzhNY1dvNFQ0S1FkWCsrNndwWVJrQnVaMEg0?=
 =?utf-8?B?cXpyaFZ0K1VWZ1BhaG5oclFKN0dVdjdpNFMxY3ZxY1lrU2pkZ2F2bXoxZmt4?=
 =?utf-8?B?YmU1NFpwSERHc2l4WWlLK0J3RVI5Z0FOZ2lQZlVlb0V0RlFOVFNzdXVFM2RM?=
 =?utf-8?B?NW9pamw1bCtBKzhUNkkzQXA4SU80VjJINUNlZzRaOUpnYTZjRDJYR0d4emZp?=
 =?utf-8?B?MFRVU1pGQWNwUml0S3JwK3pQN0VReEFtNUJReHFKektVQVljc2srWmdLWXZr?=
 =?utf-8?B?RkQ5OS9zQmhEbVRsQ1NJV1RuT3B3RFRNNzZXVmYra0dGSDlScEViMFB2OEFl?=
 =?utf-8?B?cXByYWpGZ0RKNk1vNlptVEwyTHlOMFppS0dIV2RYSWI0RlMzQmpYVGczWnJ4?=
 =?utf-8?B?T3NFMG1RSzRMUkhZd2ZQK2J0bFI2M2xLVTg1MkVTY095QzB6anhoVUxmbGVZ?=
 =?utf-8?B?cTJqVzFUVlVvUkpzRlQ2akVRR205bEl6VysvU21IWDEyNFdwbEo0Z1N3bEZG?=
 =?utf-8?B?Qllld2xlMXhLMnIzMzd2R0JhWVBpZ1VkS3NQWUNHWnZJOXBmV0lSL0Zac3cw?=
 =?utf-8?B?N3RsL3pneE52UGJTR2hOWHB6Qkt5bUwxWkQybnpWamJxTVo3MjlCdyt3YkhK?=
 =?utf-8?B?UmttRVJnNldPY2x6WnVTaHczNkRyajFXYUdtSUFtNTdMYmhBbFlVNlhOVWsx?=
 =?utf-8?B?Q3Y4OUt2THlGNlJIMUNxQTdEQW1BODZ6R3dMSjcrNXk3T0FQVFQ3U1BkY0JU?=
 =?utf-8?B?ZHRqMk83T3g5YXRzYk8yNk9vT296VTh6QmprdW1nTW9UWWc2N1NpaU1PQStx?=
 =?utf-8?B?UDJGNnhPd2lJM1FNdm1JRUVMRW5RNDBHcGpDMHpIWnc0dFo3WFdOZ2wxbU1a?=
 =?utf-8?B?Wm9VMlVGVGVtQXprZTZOUzhnRzN5UW9HdGRiTHVSSkNBT0JkVGRKOEtMSWNW?=
 =?utf-8?B?MTBzc2liV2EyOElna21NYy9yNzBGWUxwMDVqMkFZY0lCOS9EenJaUUJWL1Nz?=
 =?utf-8?B?ZXJNWDVNN3ZVT3NjUHZLQmNKYXVvZEFob3ZxVjhyN2lWZzlzdFhRR1BEK1lz?=
 =?utf-8?B?WE1tK25ERFZrRkxTNFdqY3dFcWE4NTQ2TzVscUx1YTA0aDM4YlAxdThzVkZy?=
 =?utf-8?B?dURNTy9samhMWStJbGNsd1JiekhkQzVsMXlRa2FBeVNtU0tSWE1YTkx4dnF3?=
 =?utf-8?B?OWJBMDJGVkkrbW5BZWdidkVPNzVQTEVjc3VYVEZEZVpuTW9UTXl5Z05RZy8y?=
 =?utf-8?B?SGpxcTlieUkrTWZZTllBb0R6T2NNcitDbngvMXFEY3FFQmE0ZTduRXVKUHRH?=
 =?utf-8?B?VWxuenFNUlYvblcrTXlwM0tkZThFRk51SkM3ajViYXRqZGc1VHBFTng4VGpG?=
 =?utf-8?B?dm5BRFFWeHIwcjJvKys5S0dCRHJSNFBacWpVSDVnRFRSanluZElVS2xLNFQx?=
 =?utf-8?B?OVJ0K2FWc1Q0TGl1dGwyVXdlTlY3SHA2MnNFT085WnFmeDdTUjNtVHJNUkl6?=
 =?utf-8?B?WkVHZExMNE5WV1NCYytqUHB1dDIwcWUxNmUvem4rOU5RT2JLa2oxT1dSY1lP?=
 =?utf-8?B?RWs1em5MdkVCVGx0eSttWGMwdlR2Z0lXamYyaWJZa3BHUUZ1RWR2aFJTRjRp?=
 =?utf-8?B?UVpQQllCQnRBTW9ZZVBYQTBKRjVBalV1MzhhVmw1NUN4YUhjZE5HN1d2bXZI?=
 =?utf-8?B?WXRYYmJSdmxLOVN1Q28rS1lQSU9HWWZ1TGlZUTc2VUllM1BSdW9ZVWtQeElj?=
 =?utf-8?B?NlBmdWRGYVZ1TzVTVGd2aUFNQW11UUZMRzJMRzdBRmtSemRCMUF6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3926f4e3-11cd-412e-b43c-08ded2c60514
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:28:26.4392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YAmtrALPRERAmJNIM5o0WYOXwylBGSQSeODjjOekVBTYAVZi1d68IXKJT5uv27yDkkCFoH1dPvNyV6nKNmIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8336
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

On Fri Jun 19, 2026 at 12:08 AM BST, Danilo Krummrich wrote:
> Extend the auxiliary driver sample to demonstrate both access patterns:
>=20
>   - registration_data() with CovariantForLt!(Data<'_>) for the covariant
>     data type that holds a plain &'bound reference.
>=20
>   - registration_data_with() with ForLt!(MutexData<'_>) for an invariant
>     data type that wraps a Mutex<&'bound Device>. Since Mutex<T> is
>     invariant over T, MutexData cannot implement CovariantForLt and must
>     use the closure-based accessor.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  samples/rust/rust_driver_auxiliary.rs | 94 +++++++++++++++++++--------
>  1 file changed, 68 insertions(+), 26 deletions(-)

