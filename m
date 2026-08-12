Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C7EC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9050610F142;
	Wed, 12 Aug 2026 22:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvwVCxn6";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B0B10F142
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkmIXeinXkZk2sqNnLzo3e7at+uCTizC+WkiSuLDDWteCnbkFzAxgq3fsk2709/pE5ssAURpTDd0Aw2Lk+4IEjcFibXXk3VyLxtDO36EhbBSesgT7WOAXtW7vWBKu8SjGdQ28geKoBVPZiH77qcFisCmzAuyLp4FWVtpKQ+LVTKvwIid728iGeGaMJ2vX1y52kqqO0cAlYNsbiMgXQR0ERpWdfui18NRB1Ndh2uNqDicS+i5XCmSHjKnc7eK87My1JdivY1bwtO3Ovj87lZ4Kr8UgK36fShovFWAQvyjQ5Vfe3iIEVK60o0zdcBtIo6X26rQq4Hgc+n+nLqrr3us6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpepInfzCoGrqW0Q/akDUvXPleU8qsuwWJ8cHe6VSxM=;
 b=vfSSQU4T9WcRgDHmzpvVDQ3S6TolrhnuFRqCYEoBaL2/H4qp8S66ndoJn+z7eU59/KIWbR+1IwRbPKCF3QJ2Q2WFP1onqnTWa4rKmRdFAyAyDKUnvZKWd7LjSfQw9j4nmiSbRvW8lHpfCYGhY8VfqKdoT9MhQAA6O+F6ntnm/MfIcKajIE1OguO78onUg+MJwHkStaQSGtkRArNNrhNtF7GHIlemxF3Y/BQMhgi1Tqi8U4W5kcAqC/EhVN5+dTtFvD3Eg8jGa5vvhprdBIwV7uk334isH9V2zVI1BX9dt541b97K3Jus9Qh1A+rwTey0o9PUX+x7XUgEI9szHDJ+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpepInfzCoGrqW0Q/akDUvXPleU8qsuwWJ8cHe6VSxM=;
 b=LvwVCxn6DRuZ2hskfdGu6uWe3k/Q74Gr9h2h+pZoQavsg4Fn2Yf3p02oT9ufCg3c/LU3YJuNC3SjTq1HTfMLNo1MoJq8tCYvmrrKiBuslPEY+jyjim6oooZ3wYqoR5jR+wMQa+G17v3pdqjEWsbAOE9mpaE2JE+HfNR8Hyq9UYLbXKKIlypZgQUXcDMRx5n3NNCrREODEr1Uaf36WnY58iW0FRx71uFye90noebKXKTmK8cfLB+XWBt7isav3lLpbampCfpTErmrA/fOfuOfinusat203E5FNmWkUIDKuk5qcbh6XAC6xI6vO9E4j2lAc9vPNk25ip0P2NNyyEfioQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Wed, 12 Aug 2026 22:41:43 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 22:41:43 +0000
Message-ID: <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
Date: Wed, 12 Aug 2026 15:41:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
To: Vladislav Zaharov <vladazaharova2018@gmail.com>, dakr@kernel.org,
 acourbot@nvidia.com
Cc: aliceryhl@google.com, ttabi@nvidia.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260812113752.532537-2-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcfc0c8-58da-433b-b6cc-08def8c2e208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|5023799004|11063799006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IK2j8sTRcNEUAuJe+mpsSxWPUXUJOirMR63by2PgZq012RubUQ2DncLYvaFpMjjMiq98v0B3bKNkG4sjXjb5SJVm1ijVh+nl4UiOsMMvqvLv67S4xfnS2GU7bzbzmGeBuk6gnXgXoS/MCLnwUbWgI52wmGAUk7Mp68KlRqaYbTvbHWZNa5XCYPmuRQtLV2ExDG2IeV7Z/MfJYs9mBWmLwXuM+kpZSqJId0/dxJhMinXZ/mEzdJAxH+dHlsDqmOuyeF3Ai4tjTxTThOGvAKDL6rvVPhGwhcmlT70Wj6Uc0bql5waEKLr1EgDL9TS60RCDCji0F+Plruw2h2OXDxw0P6CXeZlITqVsroX7ND9PZ1BcZ2h6dqBlBhMsXCAgo8CuccK034svPtHMXCVk5Phr1AMV8BPPd0tZBvgdATegI6NUIOws4l2jzjbtuaf2/2nwyvz+74A/AXtffTksP6TbGEm+B8831x4CfPs4F24neGZeN35PFADLxivgzNJijf0IThq6BnwXob0Re5LeeSQJ3sKj/8S/IZ9zAVDgMuLuMK4jxm7eYizo3PNJ2cs4Pzp1wcgRE9CHu0OQoLfwZdB20djh1SteM2Lmi5jQ+eGKOVgHUy4liWIaKv9WO4h6zjfAu5uwDW26neA8cb5Lt6XjlWZZzCt7Q/JJADkIzWgp19M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1VlTDVsUW1pcFFOUFlVY3NIeThuY2pNSThHbktJSlpoWGR4a3crK2RQZjBO?=
 =?utf-8?B?TEhLaURoemlKYzU4SDNFK2VpUDNkOGtPM3Fzb2h3MXQvVWJvNWlkc3UzbW1F?=
 =?utf-8?B?eEQ2Vlc4bzNOYkVvT3Z0S20ySktLSXBvS0xUTHRGMytvWjRwTkxzTWlYUW9T?=
 =?utf-8?B?Si9hTG9Dai9rR3VpQ0dtRGh6SEpUUTJhMk84ckFBVVlXbWpZVjJNeTYxazU1?=
 =?utf-8?B?VENsQ09MZ3VSMjduM2tQMFdFNlU4UlBUOE5Ndzc4clNtS09Oa1ZZRkhtUFF0?=
 =?utf-8?B?d2RlZjBUSlhKSVQzeWljV2YvbkNBRWFxZ3JVRjRhQzEzTVU5OFJYNDBjTXQ4?=
 =?utf-8?B?eWliWHA5QnpISzBEV3BwTEYvV3hFZW1VNWhNUmVYaTJ6eUYyT2Q0dHZLSlFu?=
 =?utf-8?B?OGtsWUp3ZDFnZTJzK0R3ekJSbENKZ25qSmlOUGJzdjl1NzBhclp6VmV5ejVW?=
 =?utf-8?B?YlJnNTFqRVEwcVZGSEpFNjJqV0JUd0dZSHFDbUVvRzlaN2tVTmRwQi9PeGZl?=
 =?utf-8?B?VUM2NjRsa0ZlSDZkNmZqdTgvRFZaWkZRajgwbWFla2FUT3Y1Z2w1dzFJS1Vx?=
 =?utf-8?B?RmQ2cXo0UUJVRDJ2REZWN3daNXJwMjJ6c2xYYm9tN0M3ZkNNclJSMFJkNEN1?=
 =?utf-8?B?M2pCa05qQjBxSzhaZDV0NXBrMFVLRjN3N0FsOTBncWpzL1lGSGVrMitLdnJW?=
 =?utf-8?B?SnNxQTZXaWFXU1YwVVc1dzlweE5ON1RldVpYOTRROU1rSEsvakdQZnl0Mlpj?=
 =?utf-8?B?ZU9sc25pL1B6VWlOSzBIbzRJVExMd0kxMGhxbDRKbnBsSXE2SVNLMUx0azlT?=
 =?utf-8?B?aFBkWTgxaHAwU0lZbkFadDJwUFRzNU83bEx3N0hrVFp1M3F5ZlJWS0h2WUQw?=
 =?utf-8?B?dk1MaTJKSlVrVDRLUjdFVjhmK1gyZmI5dFhoeXdCbTJqejdWYjdEak9aVm9J?=
 =?utf-8?B?Mm1RMW4zWUVDc1hkeXRnV2J0Q2RWOFU3SlJiakdVZ3pvV0s5QzBOUzFZMWY1?=
 =?utf-8?B?dEMzdVAyd0w0TXR6RlpXTjFveTdmZ3FPMEUrOTI5WEkySms0K01BV2NscGhQ?=
 =?utf-8?B?WEl2ZUQySllvYmh2a2h0REh2cWxTTHhQNGVrYXExbXlsdDZrZlI4NWtsWk5G?=
 =?utf-8?B?RHZvNnQ4QkxFWmlIMVBmRVQ3cEJ3L0ErSlZhOWVJMDBmcDdJaHVOQTBrbHZa?=
 =?utf-8?B?d0F0WWxpaDNXVnc0YlllNjFZZm9CaTNhRVp4TkVINzdNNGV5dC80UnBYNmw1?=
 =?utf-8?B?bmhQN0FVNVlqVm01aDJzQVVkZERXTFBkTFpyQ0RXVUFWSmxWWUFNUjFJd2Z1?=
 =?utf-8?B?ZjZHTGxCeXVpSFhBdnp5ODIvd2RrNkFTL294ZEphYjRGNngra3Bjd2FOMWFS?=
 =?utf-8?B?Y1gzQ0FCQ0Ezd2dTTFJhaUhoZmJTRnd3ckRBelpjYlcvSnBybytxNGw3Q1Rw?=
 =?utf-8?B?VjRVa0FTaVJBMkgzeENQU0E3VTZQcmdvY0tuTXVKNG5rQmRjZmd4SlhqVi81?=
 =?utf-8?B?MGc2cXhkZHNhc1hRbFhaWmJ5TXpoZnIyL3JJUUN0ck9mcHdud2hxUTQzTnEz?=
 =?utf-8?B?QlEyK1FHLzRwUVl5R3VMUzk5ZWZyTlZNcHVPVXdZd0lxdGRKSGJkWHNZb09v?=
 =?utf-8?B?VzNuaHFIOGp5SWxkZjdLU2lvL0p1dlZ5SnI0clcxdVREMjRrY1pEa1l5bHFO?=
 =?utf-8?B?ek1GZmR3QmZzSUJrT3Q2QXJXTjBOSlNtRDlQMUtOeFFjck9GamFTSXJOcnhs?=
 =?utf-8?B?UitYRE5GdWVtcElNbkFrRENpOThSbVRlMHdVbExyMS9iSU1wM1dPaS93Tmk3?=
 =?utf-8?B?WkptRCtvVDcxRm55YUp1d1IzYnNMclVyTk05U3VHSmFCZDF1VHUxVFQ3dU9w?=
 =?utf-8?B?bXNsQ2Q0ZnVING03eXFNbHV4cHVpRCtmYXFTVjFlU0dOVEN3TmlFTnU0c0Yr?=
 =?utf-8?B?OVdpQmpLck45N0xjeDU3amxiVEkwYTZtNE1JQjkwUnNEOStpT3dMUFFrTWp6?=
 =?utf-8?B?U0xRZlJiZlFFZkROajhsV3BwVDI1VXVyNFlxeXVSa1RIYmVmMGJPais0OU52?=
 =?utf-8?B?TElMblM5ZnpXMVdvU0paeExhZUtiOE40b0U4dW50TXkxYjdobXhablV1VnVV?=
 =?utf-8?B?RFV5QjBkQmdlUjEyZFdiVjRPTU41VCtsWVFGbW9IbmdoMzhqN040VzNaVEhk?=
 =?utf-8?B?REMyekQxZEJvU3kvVVFlYm81UEV2eHlVRFU5VkxxRlNWN000Smt2dG5ZMXFU?=
 =?utf-8?B?Y05GNXg1WWxRMU0xNTE3Tk80ckJGa0tnWHRVUEY4amJOaTd6QzhWZzhOWE5B?=
 =?utf-8?B?NHc2bjdCN1IxNnhjMXd4K2RHVVNFdUNHNndLendSSkpML0NYK3M2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcfc0c8-58da-433b-b6cc-08def8c2e208
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:41:43.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIzaWPGcpQcOsuE5Nn63KU+e/4dGCZu4MKwgxyaMlqF8lTfvSpxRd6oX9dj9dJsQAXFHuS23mHi015tvzaXS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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

On 8/12/26 4:37 AM, Vladislav Zaharov wrote:
> The GSP-RM log buffers are exposed through debugfs, but the Scope that
> owns them lives in Gsp, inside GspResources, inside the Gpu built by
> probe(). They are DMA allocations of the device and cannot outlive it,
> so the entries go away as soon as the GPU is unbound - and, more to the
> point, as soon as probe() fails, which is exactly when the log of a GSP
> that did not come up is the thing one wants to read.
> 
> Add CONFIG_NOVA_CORE_KEEP_GSP_LOGS. When it is set, dropping the log
> buffers copies whatever the GSP wrote into memory owned by the module
> and exposes the copies until the module is unloaded. A buffer whose
> "put" pointer is still zero was never written to and is skipped.
> 
> nouveau does the same behind its keep_gsp_logging module parameter. It

And so should nova! (Except for the strangely worded "keep_gsp_logging"
param name.) See below.

> recreates the entries under the name of the GPU that just went away;
> nova-core places them in a "retained" directory instead, so that a
> device coming back does not find its debugfs name taken by its own
> history.
> 
> Tested on a GB203 (RTX 5080): the buffers survive both an unbind and a
> failed probe, an older copy of the same GPU is replaced by the newer
> one, and everything is released on module unload.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
> ---
>  drivers/gpu/nova-core/Kconfig      |  18 ++++
>  drivers/gpu/nova-core/gsp.rs       | 146 +++++++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs |  19 ++++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
> index f918f69e0599..d87c146f0f26 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -15,3 +15,21 @@ config NOVA_CORE
>  	  This driver is work in progress and may not be functional.
>  
>  	  If M is selected, the module will be called nova-core.
> +
> +config NOVA_CORE_KEEP_GSP_LOGS

I'd *much* rather use a kernel parameter: keep_gsp_logs, instead of
requiring a rebuild of the kernel. As you mention above, nouveau
arrived at the same conclusion, and yet even after mentioning it,
you went off in this other direction, but without explaining why.

If someone is debugging, all they need to do is reboot with that
parameter, in order to get the logs. That's a big improvement over
requiring a kernel rebuild.


thanks,
-- 
John Hubbard

> +	bool "Retain the GSP-RM log buffers after the GPU is gone"
> +	depends on NOVA_CORE
> +	depends on DEBUG_FS
> +	help
> +	  The GSP-RM log buffers are exposed through debugfs for as long as the
> +	  GPU they belong to is bound to the driver. They are of most interest
> +	  when the GSP fails to boot, but that is also when the driver tears
> +	  everything down again, so the buffers are removed before anyone gets
> +	  a chance to read them.
> +
> +	  Say Y here to copy the buffers into memory owned by the module once
> +	  the GPU goes away, and expose the copies under a "retained" directory
> +	  that stays until the module is unloaded. Buffers the GSP never wrote
> +	  to are skipped; the rest cost 64 KiB each, for up to 192 KiB per GPU.
> +
> +	  If unsure, say N.
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 13f361406a6c..7e2aa2dfbea3 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -3,6 +3,8 @@
>  mod boot;
>  mod hal;
>  
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +use kernel::sync::aref::ARef;
>  use kernel::{
>      debugfs,
>      device,
> @@ -133,9 +135,30 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>  
>          Ok(obj)
>      }
> +
> +    /// Copies the contents of this buffer into memory that does not belong to the device.
> +    ///
> +    /// A buffer the GSP never wrote to yields an empty vector, as it holds nothing worth keeping.
> +    #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +    fn snapshot(&self) -> Result<KVec<u8>> {
> +        // Offset 0 holds the "put" pointer, which the GSP advances as it appends entries. It is
> +        // still zero if nothing was ever logged.
> +        let put = io_project!(self.0, [build: ..size_of::<u64>()]).try_cast::<u64>()?;
> +        if put.read_val() == 0 {
> +            return Ok(KVec::new());
> +        }
> +
> +        let mut snapshot = KVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
> +        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);
> +
> +        Ok(snapshot)
> +    }
>  }
>  
>  struct LogBuffers {
> +    /// Device the buffers belong to. Also names their debugfs directory.
> +    #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +    dev: ARef<device::Device>,
>      /// Init log buffer.
>      loginit: LogBuffer,
>      /// Interrupts log buffer.
> @@ -144,6 +167,127 @@ struct LogBuffers {
>      logrm: LogBuffer,
>  }
>  
> +/// Copies of the log buffers of a GPU that is no longer around.
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +struct RetainedLogBuffers {
> +    /// Device the buffers came from.
> +    dev: ARef<device::Device>,
> +    /// Contents of the init log buffer, empty if it was never written to.
> +    loginit: KVec<u8>,
> +    /// Contents of the interrupts log buffer, empty if it was never written to.
> +    logintr: KVec<u8>,
> +    /// Contents of the RM log buffer, empty if it was never written to.
> +    logrm: KVec<u8>,
> +}
> +
> +/// Log buffers of GPUs that are gone, and the debugfs entries exposing them.
> +///
> +/// The copies live under a `retained` directory of their own instead of next to the entries of
> +/// the GPUs that are actually bound, so that a device coming back does not find its name taken.
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +pub(crate) struct RetainedLogs {
> +    /// Parent directory of all copies, created together with the first one.
> +    dir: Option<debugfs::Dir>,
> +    /// One entry per GPU.
> +    gpus: KVec<Pin<KBox<debugfs::Scope<RetainedLogBuffers>>>>,
> +}
> +
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +impl RetainedLogs {
> +    /// Creates an empty set of retained log buffers.
> +    pub(crate) const fn new() -> Self {
> +        Self {
> +            dir: None,
> +            gpus: KVec::new(),
> +        }
> +    }
> +
> +    /// Releases every copy and the directory holding them.
> +    pub(crate) fn clear(&mut self) {
> +        self.gpus.clear();
> +        self.dir = None;
> +    }
> +}
> +
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +impl LogBuffers {
> +    /// Preserves whatever the GSP logged, so it can still be read once the GPU is gone.
> +    ///
> +    /// The buffers are DMA allocations of the device and cannot outlive it, so their contents are
> +    /// copied into memory owned by the module and exposed through fresh debugfs entries. Those
> +    /// live until the module is unloaded.
> +    fn retain(&self) -> Result {
> +        let logs = RetainedLogBuffers {
> +            dev: self.dev.clone(),
> +            loginit: self.loginit.snapshot()?,
> +            logintr: self.logintr.snapshot()?,
> +            logrm: self.logrm.snapshot()?,
> +        };
> +
> +        if logs.loginit.is_empty() && logs.logintr.is_empty() && logs.logrm.is_empty() {
> +            return Ok(());
> +        }
> +
> +        let mut retained = crate::RETAINED_LOGS.lock();
> +
> +        // An earlier run of the same device may have left a copy behind. Its directory carries
> +        // the name about to be used again, and its logs are the older ones, so drop it first.
> +        retained
> +            .gpus
> +            .retain(|gpu| gpu.dev.name() != self.dev.name());
> +
> +        let dir = match retained.dir.clone() {
> +            Some(dir) => dir,
> +            None => {
> +                #[allow(static_mut_refs)]
> +                // SAFETY: `DEBUGFS_ROOT` is set before driver registration and cleared after
> +                // driver unregistration. This runs while a device is still bound, or on the way
> +                // out of a failed probe, so the driver is registered and nothing can be modifying
> +                // it.
> +                let root: &debugfs::Dir = unsafe { crate::DEBUGFS_ROOT.as_ref() }.ok_or(ENODEV)?;
> +
> +                let dir = root.subdir(c"retained");
> +                retained.dir = Some(dir.clone());
> +
> +                dir
> +            }
> +        };
> +
> +        let scope = KBox::pin_init(
> +            dir.scope(logs, self.dev.name(), |logs, dir| {
> +                if !logs.loginit.is_empty() {
> +                    dir.read_binary_file(c"loginit", &logs.loginit);
> +                }
> +                if !logs.logintr.is_empty() {
> +                    dir.read_binary_file(c"logintr", &logs.logintr);
> +                }
> +                if !logs.logrm.is_empty() {
> +                    dir.read_binary_file(c"logrm", &logs.logrm);
> +                }
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        retained.gpus.push(scope, GFP_KERNEL)?;
> +
> +        dev_info!(
> +            self.dev,
> +            "GSP-RM log buffers retained until the module is unloaded\n"
> +        );
> +
> +        Ok(())
> +    }
> +}
> +
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +impl Drop for LogBuffers {
> +    fn drop(&mut self) {
> +        if let Err(e) = self.retain() {
> +            dev_warn!(self.dev, "failed to retain GSP-RM log buffers: {:?}\n", e);
> +        }
> +    }
> +}
> +
>  /// GSP runtime data.
>  #[pin_data]
>  pub(crate) struct Gsp {
> @@ -191,6 +335,8 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
>                  },
>                  logs <- {
>                      let log_buffers = LogBuffers {
> +                        #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +                        dev: dev.into(),
>                          loginit,
>                          logintr,
>                          logrm,
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> index 35a8b1214b0e..59146450ab7b 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -30,11 +30,23 @@
>  // TODO: Move this into per-module data once that exists.
>  static mut DEBUGFS_ROOT: Option<debugfs::Dir> = None;
>  
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +kernel::sync::global_lock! {
> +    /// Log buffers of GPUs that are gone, kept around until the module is unloaded.
> +    // TODO: Move this into per-module data once that exists.
> +    unsafe(uninit) static RETAINED_LOGS: Mutex<gsp::RetainedLogs> = gsp::RetainedLogs::new();
> +}
> +
>  /// Guard that clears `DEBUGFS_ROOT` when dropped.
>  struct DebugfsRootGuard;
>  
>  impl Drop for DebugfsRootGuard {
>      fn drop(&mut self) {
> +        // Retained log buffers own debugfs entries below `DEBUGFS_ROOT`, so they have to go away
> +        // before it does.
> +        #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +        RETAINED_LOGS.lock().clear();
> +
>          // SAFETY: This guard is dropped after `_driver` (due to field order),
>          // so the driver is unregistered and no probe() can be running.
>          unsafe { DEBUGFS_ROOT = None };
> @@ -54,6 +66,13 @@ impl InPlaceModule for NovaCoreModule {
>      fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
>          let dir = debugfs::Dir::new(c"nova-core");
>  
> +        // SAFETY: Module initialization runs exactly once, and before the driver is registered,
> +        // so no probe can have touched `RETAINED_LOGS` yet.
> +        #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +        unsafe {
> +            RETAINED_LOGS.init()
> +        };
> +
>          // SAFETY: We are the only driver code running during init, so there
>          // cannot be any concurrent access to `DEBUGFS_ROOT`.
>          unsafe { DEBUGFS_ROOT = Some(dir) };


