Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927DB606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LpCdPsND
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0331D10F99F;
	Wed, 25 Nov 2026 02:24:20 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B300610F9A0;
 Wed, 25 Nov 2026 02:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiwM0tX9AtUZVKjRn4o1prO9Tza18+pY4RAI/x1Zrv5Pd//AhzpJbp26xHTp6AHhIsenJT0T7wX0GDPFYg2QjFj9HyBa9l4nnK9oZPh7wDKVcKGFdQlWTgfvqb3yzhx33O3/7VnxGP9YnJPtwkRtZOPc7gkDTVtI8Vnzd2R2CU1zl0wU/Cd0f1KcWWT9G3ziqGa3UCdhWeGyxOCynj7hdONHlzO0+0ZFTDczfYgVHqk6Yg446a8Fh3ASyZr/J+sT57am3X/l3yao/+CmgVe7MApRkPRWgqfSdzhsGBiKQjSDfmB4zNqPf2IdeOGKSJbJT0XSufaB0Ot1vqJyrEWFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPjX5EG+LBzU1NjewPVGY30EVxUjPW+qVxhjlZrXgik=;
 b=rKrXYigImZoRxRkgG+U/68QBQlhiUhbq71wjZTdg+tLWLfWpx13lIy1AJKk+QlWYORY1fJAEczvkGI+2qA1ineLACSqgzPQfQ20M+2P1ZtbT/C2BoaKW+e2Rtpa7YX4pdlHSIdI2w6j489Z4t4AMkoOxfsz5kMwAW787he1kWSq7AQLljcZ3ygDOXqBxFP+oYQFk+H7t8ngXr4qtD9NgPhweDcJ755Ue2rXcqaaoE78gTIj8gRDWC4+7bNSdYaxszrypi7pLLi3aj2NjT/JdTahncQWz5u8tERlg456SUg/mo6W4i0GJuVG9e+VzL3Ks9O9tqXyfxDOSRccezz8tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPjX5EG+LBzU1NjewPVGY30EVxUjPW+qVxhjlZrXgik=;
 b=LpCdPsNDD06IpFh7oOyzfO5VQLcbAaKkmaQ6g/iWL34AEieyr6WsXejPNQeGJfNw/z41Pc0pcjqNlAhWw72D8czwEtjzYXvdR7URsiWJqNO/hw6yJDGvNNF79GwPu94LJazjgYBhWlh9WZi9sh37il2vLJLdDMl2gAOCsXu1NRUBxWtWKxLe16RnshccnMh/AxMy3IHxtwGRz+69NtjOG5OPSGqMUP5SPG2eVocbeBTF+kuXtTE4ytoa4HF5B3AvNgSYXaYxn7Ahx9sAdF5whfyVvT/Bxw1xK3Hs08AdW3pZ0Hf2mZq3A74LEZU265VwxU9RSS9SgVPd2c/lL9tUCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 02:24:07 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 02:24:07 +0000
Message-ID: <95e63e66-1143-4c81-9206-68149ce00071@nvidia.com>
Date: Tue, 24 Nov 2026 18:24:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nova-core: only bind to GPUs when explicitly
 requested
To: airlied@redhat.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 nova-gpu@lists.linux.dev
References: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
 <20261124-nova-nouveau-gsp-v3-2-e1440479ded6@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261124-nova-nouveau-gsp-v3-2-e1440479ded6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e1ba82-45f9-46f8-b142-08df4a9b2ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|3023799007|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: DmL8CB5cdcKYhcAufeOBwQ7uV8VBz2jvaIuKDK88Vy7XNBeOG1SXHqD5eJR8XoSrYbpPwbtZIkfnRIQOgEFAU/JSNskZAjCgvr7FwwLr+YD4PwfGL/nn8t1tjbwOjUHheq6sIeJy+i/Ph8Op6OoS9qHRtZFELvwwcnsJ0oiW65rNV+9qYj41cbydOrdrSsqdyY6OrQe82Rw/0AZyPIZHbpUqADXARDPA3gie3Vu6CGyFWWJyJd/J6WdIyzFGNwHcdBYA6EHGeqiZMR84t/dEtThrlxYtZ5u7BmvPW6nU7ltlDniD+G2rWmsyOweF68eztARE5swR8pwGxBzoTS7jJzf8weaKEgO+e9svP5vhabzYGdIHA16786WClWi4RbJ4CKy8gvntDKKvQNXokneN5Pn5j1PTpe78AsFvhNDLvfjGDWU6mPbWd5+bhjS+K0Mg9wbPK1I6y+QNEnaf1c0xmR6WjrW28ujDXZ9PRMUUpnpsKTGJor3OOf/PE/NN4GMe4Ut0fWglf+FJY0mLgNlWX9BzHi9IwF1MJwTnQbPeKwuo8Pm0EGWPMMFCdPKZLsL2dxrgpbMTDtCsKStpFUSD7QlXKSqt1yYcy08kJzbgWQh4rrroitiZS9pZgxodw7inYHwXplOo5xE8iDOmxmLN9aV6DkM17aOwRy332A19KqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkdPVmpWbEpVaEcra1o3SkpCR2pvMUp4enh1ZytPWlFRblBCY0crM01TeGo4?=
 =?utf-8?B?aWFla0swTmk0R3c3Rmx4dnFkTlZ6R3NyY1BaQjRvOGxLZFJKZjhmMVh4cit6?=
 =?utf-8?B?NmpNelJSZ2cvSG5DSzRrZmFwL2pqUnRZek5oMnpiOU1pRFI4L0ViUjVLWlQ5?=
 =?utf-8?B?bWs1dUJKTjdCSU9JdGZoZmxCQk50RGQzMGxkNklkYm1IdnFYR1cwS2x4clZz?=
 =?utf-8?B?SkJuaUcva1RMTHFRZURVWVJmN1QyTWdMeFJLSjRpT2V2S2Z5ZWFkSzNPaFR5?=
 =?utf-8?B?dlFUbE1jZUNnNEFiLy94TG5mVzVDd3N6VEM4em1oaGtZbUdoMVFKcWJCU3ZX?=
 =?utf-8?B?dHdlWEJxWEFhc1QwTDRuSjZHaTdDMDZHcTRrUnFwREhPMTNIM0U1OEVZKzBq?=
 =?utf-8?B?cVc0cnlnNm5sRFdBazB5L2l2TDFyb1FQOC9iUzRsVU8xSEREMWFOREprdVZN?=
 =?utf-8?B?L2xHVy80V3hXYWZGZ0x5UUtSYmRzakJPN1R6dWdBelV4YVgrYVRibm1FSmxv?=
 =?utf-8?B?QXBZdUxMTmdQeGp0RmhHcFBXLzY0ZVRWTURVVUNhMkxlV2JBREZUK2ozc1li?=
 =?utf-8?B?ZkVWZWtVaUhTM3g1eWNPbVBkM1A3WXhzcjFjNk9tR0tWT2ZMUldSUXV4cHZi?=
 =?utf-8?B?eXQvREQzMGM0blVjUjVidTNuV3p2NURib0JjaXFwdmF2NUhMcE5ERDYrMWFq?=
 =?utf-8?B?NGFncllUR2ZWc3ZVblFIa0FDcVBXeTdkT2RiUzgvTG9EZXNQREk0QytwSnZ4?=
 =?utf-8?B?M1Ruc0pLbDRzR1JMR1ZlekE4WUNQdlBSdUVvRjBqU0FieTN3UHY2TUVhVjdZ?=
 =?utf-8?B?Y0hVbUJhNUtKdmkrYnZlZTk3QVdwKytnbHR5WXlpZnBlNTNCYmpmOWJicURo?=
 =?utf-8?B?YXFHUGVsUUtZYkc4OHZJY1F3MGJaMWVkTG9mY0dDeFhycVViNVg2MTdiK1pq?=
 =?utf-8?B?di90c1IrR3VoUUpRUzlNYzcxK1k5ZUEyRXNkNVJxd0Jhdkc0enNma29ZYTl4?=
 =?utf-8?B?NjhjWWRzYm1lMDlvaDdSWC9tUG5BVWZLK3RvcWxuc1JWZzEwa05LY21JUU52?=
 =?utf-8?B?ZUwzNmFlYS9Ma3lIQnRqeHFySHlwZ2xOSTZSSlRPUVZNdXNObzV0S0pUU2hv?=
 =?utf-8?B?QXoyaDFTZ21lNVlWMXNZbWNkaC9PWVc3Nkk0MDNEd1JHaW8vUnBFQlpvUk9s?=
 =?utf-8?B?NTRhRHAyZUVRT0xlc0hCNzFTMk9VcXlPZFlldHJnNnR3aW0wNktSRUw5eHZP?=
 =?utf-8?B?U1lGRktRUklvOEcyVXExUXVDV2pObGJnMGp4YzlSaGVweUhDYXEzMytvNE55?=
 =?utf-8?B?SllYTUEzL2ROWnVqSVE3cFVLajdiOU9UZzlXQXVTZys4dHBCdGF4M0tmZnN5?=
 =?utf-8?B?N0ZTZUw5TGFWbm56U2Z2TGhDNWN1RWJSSVkycTh4UXFwZ2ljcU1Oc3FMSXlF?=
 =?utf-8?B?TFdtalNyb2VUd05JUnV4NzdEZVI2cjVtYStLVUpsVC9YaU0yYzVadUVaZVJ3?=
 =?utf-8?B?eXFSWXA0SkVmdnNkc2ovUytENFVXVXFEbld0c05tUjE4YVpzOG1hSjhIb0Za?=
 =?utf-8?B?UE1qRFJmTHIreHg3Y3lUVVFPbmtqVmdYZkFmUzJwS1QzUHptMTYvdXNBS3Vr?=
 =?utf-8?B?VEZkN3JDS25ENll0dCtVd0JUcDBBeG9hTXA3TVVzT01Cd2dFU25SKzVOU0pr?=
 =?utf-8?B?OVh1UWdGQnA2eGlaSEdJVnJNajJDYXVrUVpVUE1oTXVKejZ6MWJCSkxJQ2R1?=
 =?utf-8?B?dzBRMHl2aG5wVkNlT3VpNTV6eGlwYXV2WjRrbWYvbFI3YVNLNGpnc2ROWXVw?=
 =?utf-8?B?S0ZsanM4TytHZUFNeGpBdDIzSVdTeUJiektmS1BnbU1MVnlHQjZWMDg3L3lu?=
 =?utf-8?B?Ujlidm9qN0ZiQ0V5NWh2TllYVzFzMFVBeUE4UHZ6bGJ4L3lOR294dktZNHJB?=
 =?utf-8?B?QlAvbnBvdlBuYjdHSFE0MFpGL3o0RFNZYjZDME5XN1lqeUFFTXlhZkE1MU5U?=
 =?utf-8?B?WjJjV0tJT1NUcFNlcWQ2c3FFNGVid0VHUFV6a2w4Slp0ckpSY09iOFdrWVpV?=
 =?utf-8?B?WXhsTENpL0prUG13QVZkbE5GMWl4NDZoSXA5NG1pT3RBNUszdHpsOHVDY0Zt?=
 =?utf-8?B?bjBjeUd6ZGNvb3ZvYUx4c3JJZDlBSkJkbDNMdUZHUGdCZnlxNnJIeWZ0d2lm?=
 =?utf-8?B?T2ticDh2STBxRzZwclhBczFSYU9GNHM3RGxlVy9kdXVqM1lxU1hrSjdxaGxw?=
 =?utf-8?B?SnJ5WTlMNUVhaVc1WnlqOU1jbGFjc2xzZXFFdGlWZVpMeUdzWTlwWnpibllJ?=
 =?utf-8?B?M054Wkd5Qk5STDN3dEpkeG0yaEI0RC9SZFh6MDZqclJTOG9YWmlTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e1ba82-45f9-46f8-b142-08df4a9b2ed4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 02:24:07.7795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vop6s3CjBFhkcyWFYd3MOjgQbK3jEmyUsyB8qgb201c1VHVqOGpI+nT3V969Z+Hj3rOy6JKtbkoiTUvoFGHiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 9:50 PM, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
...
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index d6bc972d47c7..e89967ef0cd5 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -105,6 +105,10 @@ fn probe<'bound>(
>          dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
>  
>          try_pin_init!(NovaCore {
> +            _: {
> +                crate::NovaCoreModule::check_bind_allowed(pdev)?;

This runs before Nova has read the Chipset. The PCI ID table matches
every NVIDIA VGA and 3D controller, so pre-Turing GPUs go through this
check too. That leads to the problem below, in the dev_info!() message.

> +            },
> +
>              _: {
>                  pdev.enable_device_mem()?;
>                  pdev.set_master();
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> index 84f777844592..483e5c1d427b 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -68,6 +68,25 @@ pub(crate) fn debugfs_data<'a>(_dev: &'a device::Device<device::Bound>) -> &'a D
>      }
>  }
>  
> +impl NovaCoreModule {
> +    /// Check whether nova-core is allowed to bind to GPUs.
> +    ///
> +    /// Binding needs to be requested explicitly, either through the
> +    /// NOVA_CORE_BIND_GSP Kconfig option or the `bind_gsp` module parameter.
> +    /// Otherwise, NVIDIA GPUs are left to other drivers, such as nouveau.
> +    pub(crate) fn check_bind_allowed(pdev: &pci::Device<device::Core<'_>>) -> Result {
> +        if crate::module_parameters::bind_gsp.value() {
> +            return Ok(());
> +        }
> +
> +        dev_info!(
> +            pdev,
> +            "Not binding to GPU; enable with CONFIG_NOVA_CORE_BIND_GSP=y or nova-core.bind_gsp=1\n"

This advice is wrong for pre-Turing GPUs. In other words, if someone boots
with bind_gsp *not* set on pre-Turing, they will see the above dmesg
output, but setting bind_gsp will not cause anything to start working,
because Nova doesn't support those GPUs.

Maybe the simplest fix is to change the print message to make a much
narrower claim. Something like this, in the same form as nouveau's
message in patch 1:

    "Not binding to GPU (bind_gsp=0)\n"

Doing the check later, after getting the Chipset/ChipID, would also avoid
the problem, and it is the order that nouveau uses in patch 1. However,
I'm not sure it's worth the extra code. The device has to be enabled and
BAR0 mapped before the Chipset can be read, so a declined probe has to
disable the device again. And rust/kernel/pci.rs has no
pci_disable_device() wrapper yet.


thanks,
-- 
John Hubbard

