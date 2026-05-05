Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F348FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9200510EC07;
	Tue,  5 May 2026 20:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pL8q5QXl";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E54010EC07
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta+VzS84UC1E/7ThzYlseKzfvSCZO14Z/XEco/GiTdHhwZ2SS9J67yEOfEhZ+uRMRYcxUxOwmYBIyDBBMeLdF18H07sHAJCipWBsOjIUQiVnZL4YKFU3Ep2RSavAJfJujOwVjSPrJnLfmcSFlIr5sWGsnRPNQhbzTkrCnJgVI6/FZXjzfy9sabPv3hJ3Dqog9w+RvvWRomqeU2nXv0Nz395Fyumo3Se7wepHYGUIkDuZyGlOtfH+v52X1rGI7vRxqZsP+kT/Y5rRQrxHVNcvxVkecEOwlHCzwPGMtkXKCdCMK9ASz+iChrWRKVTwFA+XiG+CiChc5mbgoeao7mKi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92GKFSw9n5m993bOOZpZVMvAxbab8nCWmSb/engq2CY=;
 b=Pg1Z8sCBwIapITfOc/otYFs/sstB+Tk1x5Er8xUwr/QZ+GTCMRIKUj4FqiPaf6ePCDDkXo2Pwb4I2Vue40lcs1K0MVQnif44xDgoz7L10yFmzG/SvU6FcOShUQ/t6G9t5KuzQrXmPgNC8IAIUBh9LtJ3K/w6qCbGeppK7byeFDymoyOAGwfxWu+flDpy5TyP22EaWJw7jmEFGqCvBG1ewo0tNbFZp11mUjYxSKa+Q220vgx2qsNxCqLzqenvPUA1hnQHpGeI7J5KIN+g70mgJPSyyeGmwNOxQKlIDGXb1BkwBh9UewUOKxzkqXSJtXVmF7OPWkcvqutPUP+m7nw48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92GKFSw9n5m993bOOZpZVMvAxbab8nCWmSb/engq2CY=;
 b=pL8q5QXlIafRWi0GHq85HjOrdDIss/kGb5bRXLNzbo9gH/04uAGAdDUpSAZEV40/Rfflm50EqoTZ6rNZGC3+Q6dAFs3LRjuoINzL5RdUcKSvacqf1+z22l3c/sf3N/ciBFX9aKC+vfefo7k96f5eTkp9y5TFCllb3MJ5sSjhbcqwGXZZuzWUnY+vu12saO1El7NQ1j6pn2UyhIfcElTU+XTwnfW4B05VBqikRsYkmCgsijfNQaH99ilX9eK9El9fpIbEmN5cZs4TPu9gqvoqVR/ihHouy++MGqcCwANavybeGNx2FyuP6MsAAKyydQPS44ALi9twjvT0J+OMzMxocg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:19:52 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:19:52 +0000
Message-ID: <66069350-3fb1-4e6b-a92c-24b0c87b1090@nvidia.com>
Date: Tue, 5 May 2026 16:19:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] rust: sync: completion: add
 wait_for_completion_timeout()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
 <20260501205825.73614-2-joelagnelf@nvidia.com>
 <CANiq72nW4ibDKYySiLo14B2W-PWbZv58d0a604cGQ_+A+ftBog@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CANiq72nW4ibDKYySiLo14B2W-PWbZv58d0a604cGQ_+A+ftBog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0335.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::10) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: f451c999-e106-45e9-38ca-08deaae3a9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: isWIL6I7H1wzo3ZGSdtH8c7rxA5OTQXq/uK4+U4U6wfiMx1UKb4e3YMYbVgM2X8ILkGB7EjugkO3xp+WRkTMvT7RqcrOBy3xdX/KOoVxXua29QMpWVifY2eqoPDxc8yAxwekFwl8kOLmH6y4vxN+0M4ooU+KNm5pWLHxSZ/tFR4sS5gd+PyT6i/fo1cEmo+VcJBvsQXNv7TYLtxtDbjSfzeF3Iw/qSm64jUpFhhdC6PucqIbFLXvkrp+fn89Vh4ZxxflVxpW7KgD8KdV9W03fAo6fQLgTzbf8Y7W4rD6FxX2/CavLjdMEk/lhwNhYdbK36t5o7JD4FXgF16rlZ7EjSR3TT7xaxbsrgdZnlD9WzkkM/MA/MuwhCOl+nmJudDET4bNnOnOv+BSQUfe/nbEvogh30Xu6KLRbOsYbZA7kfVYEkuCwH515UHqnQXFMTWrYVqSYeA/32XbZFVvRhVi9Kk3afc9FvB0/G7AZJbezbbvLbKq2ko0MjJ9f7k2PfbQGXA0d9DwGxy2TXxo9DicFAYR0y0rnJqphx+hAUJRxbtblDG560/jy5QgcDddzN2h/LXmaXoUJ648FKFeoCUwsf0hRXi3vzZzKPwr9LWAh591tcDA26FVFAouABiPf2CQA9vnuSi1TcqrH8hjtKwELNFMnm93ROXPzfcDtKRS963a99D3X/iNozDDbYJ1D708
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRneGluQjdJZXQybTAraE11MVk2elNncTBFdWFZejdoODY0OGUzbDM1Ukw5?=
 =?utf-8?B?Ty9lNmlUMjhhcmFoUWswME9hUnBJdDJNakVuMkxwSWFlU2ZBN1V3ZXp1cVB3?=
 =?utf-8?B?NzVIKzAvUkpseHZYYU1lbStHYTBiaXRxNmFWR3VDUTFFY2NKWVJqYzU5VnRw?=
 =?utf-8?B?V3NscFRGUHByM1NjWnVJMU9CeVluWXdONmU4SXZBanFXTkxoWDNkbCtkVzJN?=
 =?utf-8?B?c3hka0hlZVhXWEpTMnVpWHlRSTQyY1RKOWVDUWM4djk0Mmh6aFZRWDRaZnEr?=
 =?utf-8?B?SXFYODZ5SUN4Mitjb0FHSnVOUDlYNFB0cHQ0RWJ4NGpGMkNwVkp1R2txcTBq?=
 =?utf-8?B?dnRqSDZLQ01CK2ZTVGR3M2pmMWtIWDNBUERyc1RXU3J6UHhjaFNDZGZ3U2tu?=
 =?utf-8?B?Y05ZUEk1a2FKdURxRDlWTEVWQkowMlpMWWlMRHlLbFdTR3hWd1BqeGFMZTFa?=
 =?utf-8?B?S0ZaenFTekg5YldneUEwS2FpRjRVaDZKNHBrN0Y4WGlKOUoxYmd1WEFIakxD?=
 =?utf-8?B?L0FyRTJNbHBpUmJSVUk5Q3F0Z05nYTJxdFZzY3pEQmw1QndqUUhnMzNETUg2?=
 =?utf-8?B?b0V6Vmd4VGhnTDVTSmd3OHlrWXdFaTVOcVpnb1htS253NVJyQ1BTY0pleHFT?=
 =?utf-8?B?R2V1cWI3cEJnUnhDODlndTJNY2h4dGwva3JUOVRsYmFGcmtaTGEySk0vTWlS?=
 =?utf-8?B?TE9naCtrejhRRXBFek1ZeGJnTFJQZldPSFBBdEhERlBSKzNLSERTdnVmbE5v?=
 =?utf-8?B?anJJbHpLajdwQ21zNkk3OURHMGNvYlpSUFhxVGl1T2MvQ25WdVgwNDdaTmhn?=
 =?utf-8?B?cEtnQ2FmOTJOK1Nycjl6aWVCTTkrdjVVNFJpYWc4dHhIaFlEMjN1cWdSQUh6?=
 =?utf-8?B?WFIyS2pQSDRlajJZTHl1RTNHWGVNWXl2bDZNWitaN2lOb1gzQm9wYjlMZU5C?=
 =?utf-8?B?NE9ubzVtSzRlRC8wZWtUNGZZaEZZejE4UlRPNTNmQkN2U0NPbUxxeEdJZ05w?=
 =?utf-8?B?WEFjM3o2Ty9aK0NDQ3oyeU91bG9aY24xWm9POGZWR3Jxb2tkTThNTjV0bDN6?=
 =?utf-8?B?WmlRRFlSRE5lcldtaFdiR0ZGYUQ5SjgzV3NXTmsybzZFeUs2RE95U1g5OWdV?=
 =?utf-8?B?bzJZdERBaWhLaU56Ukt3WjRXdzZBMkhLeGhOalNZaVpEV1Bvd2l0Z1psVEsz?=
 =?utf-8?B?SFJxd1hJbWhIY3FKZU1mNzRXZ0Z4dzFXcDV4OHNOdnpZOENDbWd1WW9yZGJz?=
 =?utf-8?B?WUtxVjlFK21KWHVDMStWU2tTWFJlcktkekNhNmovbnZibzBOS0dmRzltcG9Z?=
 =?utf-8?B?UDlzemROcDJYdS92cUJ3L3V1RjArdk41Qmo4MzB1WGc0TUIrSHNMdy9vZ3dr?=
 =?utf-8?B?M2JJdVhjYTFLMkdzMDZ6dHg4YzQvV1lQYXhwazNjT2IzWFl3V2VTVGV3OWFl?=
 =?utf-8?B?R1JrcWhmQnpjd1RxYWJUWDVhM2JHWk5rOW1rejZ5TTFpQVVCTVZ4SnRxMFpO?=
 =?utf-8?B?dzc5eEkrQTVFNGZZQ0x1VVgwN2lZQUVDWkF3SE9YMDFkclM0L1NYT2VyZm5m?=
 =?utf-8?B?M0JkdCtlNS9UdlNRYnp5WGFLK2U1eGFoaWVoZmxEUVR1aDV6QndJTXFuUDF6?=
 =?utf-8?B?Qzl5MnMxT2VUL0lERytZVHJJOVg3eWFFUEp5T21WeTRRUXNGMllnNk1BRXJs?=
 =?utf-8?B?MEMrMWdobmhOSWJ4d0Vxa2gxM0Y3UUp1Tm16TDgzWC9uYTFUR2tBT0VkM2JJ?=
 =?utf-8?B?SXFTN2dNQ3pkMDJZWVoxL3N3dlVqaXhtUHRGa0c3Z09kMU5PZHVYbVVEdEc5?=
 =?utf-8?B?bDNTakNtOW5JeDhkSkJtVFFqMnJTcmUyMlk3a2lBMXlqUzVsZTgxak8wYTFr?=
 =?utf-8?B?bzFzdm1JK3JhaVVOc250djdPTkFDK1hvanJMazhSNlBmc0VJZlNRNjdzM1A0?=
 =?utf-8?B?dE5lRnF4L2lmZXNVQ3VHNjMxTmRRaEgvT2taZHU5WHJjbElSTjZlNzJOc3BL?=
 =?utf-8?B?TXVwcVUrYTRhTFRLeGl4YUluRWRna2FMMzFaQzYrdGNVMGVSOW9kTVd4UkM0?=
 =?utf-8?B?d3VBQ1E4NXppb21TeUloOThvSXV2Z2M3Q3Yva3pSNy91NC9tem9PQ2ZSRGVy?=
 =?utf-8?B?cGRTNjdVa2lhT1FXNlk2ODdrOEVpM3gyMXNlM2sxdi9VdlJld3FlbTBzZTMz?=
 =?utf-8?B?QzVWSmUrZVliRGYzU0p4VnFha0YvM3NGdW52bmh0aktBSENQdjNGRktRNG9I?=
 =?utf-8?B?dHFEUncyYnJXUzZBV3pZNEtjdFNZS09tL1ltWXpsbjlBUGh4YXVtMjlMVWdM?=
 =?utf-8?B?V3NhazMzb3g1Wjd2QXByWlczQ0krUHhsUGdlREN2L051T0lEbU9vUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f451c999-e106-45e9-38ca-08deaae3a9dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:19:52.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Vxjskr6ZOfbFNfEQJd82F87Jpqega/j0cRPuAxL4l0JCrygT9oO7DTXkkz/mm7SwyhgWSAiGPYRubS17mtu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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



On 5/5/2026 8:17 AM, Miguel Ojeda wrote:
> On Fri, May 1, 2026 at 10:58 PM Joel Fernandes <joelagnelf@nvidia.com> wrote:
>>
>> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
> 
> This is fine since it follows the other ones in the file, but we
> should say why this is the case (in another series, possibly a good
> first issue), rather than just asserting it.
> 
> e.g. a type invariant?
> 

Sure, I will make this change as a separate patch. Probably if it is one extra
patch, I'll just add it to the series.

thanks,

--
Joel Fernandes

