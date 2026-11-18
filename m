Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C54606A337
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bNB7njdO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F137710FB7F;
	Wed, 18 Nov 2026 12:11:49 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FD010FB9C;
 Wed, 18 Nov 2026 12:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8NljqThW6rssSQnaoDTUT8SdA55LuzU1JU7PB0qHDAFu/kAIU/7oaw4SOfuVmIHfG/JnFPg9z1qkwxcMuMQVFIkVKGF7CB2sqNUELXrWnjv4QM6GxZPhX8CXyKBDoGU28B+mPbqbs12bZjIiAwtzVJaDc8Ek6UeS+YVIiPKfRnAhJGp0Hk8D8j9sVEBOxviDueVPIQ+8f7z3do8WOjqB1ZiTh3x2Wc1Wkkf25amOEREsAMyUfGbjMFV7wUpAwkzji+U4JZjpzQPSwR/Bp8WzWfxyxAIIeUKjaivOS6CCgg1kWUW7NPzpoC67zsYEgEi+lLATj5AGf6u/Tvbulbtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZOJfcPvfcPzFAhulRxEN69saoo9gATIT2uEQBXDjVE=;
 b=cbWSV2r8EDJY0iesYxl2y8kmsbmmBcjEl3G1pGxPmZXa98rIKhSYIeQP3Ne5fjPEDHbXa0LDI5nTcZw0HKrbYT20rDUYk+caiCJQ4/oiyDcyMVe83DdykAbXH8h2Q95U5Pd1Pm8Wum1XYzpri94fsCDri66Q5nfC+LUiybw+0wYicpD90q4I/9mgV0duc4gQmvc8WwCvc0smPvh+TKE9p5u8LUChmDMKKHOk8gZwg+UX/l8ODSAobiNL4iNrJpnMXIGdF4c7jR2TcV7YqkY8iBdj1fRhwh4atB2+Rdv8T55aS4Y+sj0cEFpf9UrRfYXE634+dv/pjb2gcI+TK3kZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZOJfcPvfcPzFAhulRxEN69saoo9gATIT2uEQBXDjVE=;
 b=bNB7njdOFcC23ZE0crItsT/eC9kA7l4+6BbrKrWlgK3Y2/VtvnxyA5DlkBeXCfodKsHT5dFbreNBhRdhBKp7dSsEF9734E+l0eibNjOACd77sDye0PmfXKgsSQJMDz3ZyVXua+Zi50jP0NZNso4fFJrS7pmp4zw6Ej6szckNAWU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Wed, 18 Nov 2026 12:11:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:11:39 +0000
Message-ID: <d7179bdf-daa3-4ed2-a45e-ef2b99d116f1@amd.com>
Date: Wed, 18 Nov 2026 13:11:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/radeon: stop the GPU before kexec
To: Nickolai Zeldovich <nickolai@csail.mit.edu>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261117170328.56738-1-nickolai@csail.mit.edu>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117170328.56738-1-nickolai@csail.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0040.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cd6d5e-468b-4428-eeb2-08df456d19bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|6133799003|5023799004|11063799006|56012099006|261022075727099003|261028144727099003|10067099003|261021121427099003|261009223027099003|261021135927099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: uGLaXhmo/FGBtqVGC4cotz8I2HbIU+bNYNBAqKfHksx6TvqTsr8kqV7mAlRNHRPLw2zBglIayK211+DKQwohSx9PkTQXtfevzzIWjhb9pqh9+UdbdOAK6RZXFoPf5p7CnG9ajoOTJIjtSbNHOVc/jzbwT11MZW4QmKe2pjnjePHTlOzC33RjitEcQI26AZVYH8cWXYEfFtv4rZ2ZzrTlDyYMqsdbLqdJaxhtnWJbFtaW4tNMZOzEFqaQ8g9HKgQSVpi04qTJSOBDDag/fQy14biV7iULQXGsKqsmyxhwyQCgeldH3Bj95ChraVduZTmD+CD41KBtxpu0pOUBDihgvRCAY/iBXSOqHPCyv/nGId/mC8n8j/pIa1DH5U65WjKmJaNPX2wvkoxSYsfTf6iEdxuAvqkWom4bUwBN3ruWUfFP6nk9ZKhj9m2/64X3CJ4CoLawhu7pGXjzJcp9gZf9XUEKfPTWrUOvFeUb6xbkxduxwNEXV89ll8X1cMXpvsrByFm5bvA84i387lUnT7oES5SsA7VNvht/lOqM+Zf/s4/T7fCNnED/DOW0jteqPaj3jWb4NXVIz4J62vS3Hbt7KFTR+rgaqbpKKxnslK+EFcQLyHXHhnpkMfFBAKZxK8nB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(10067099003)(261021121427099003)(261009223027099003)(261021135927099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzIwbTc3ZFdMejViV2wzeGVZV0pMQ25jWm5abXF3b01wTUJLTDZQSFQzcEtM?=
 =?utf-8?B?QmNWbXJONVhuNjQzb1lsV1hvLzRuaW5TNStuL3M4dEZ5Y1FId0VRaDFQem95?=
 =?utf-8?B?R0JndjRnaGtVeDdEcjFBeDlnTGpXRmppVzV1L2pUR0pJRHFSRTdYT1lwSStI?=
 =?utf-8?B?dFB4dzNsWnNkU21nQ3Q1Wkh6aTJjOE1heWdkZm5qc25qdGc3VkJzVWdUalZI?=
 =?utf-8?B?Mkw1bmlXMWo5OGZMZ2o0UFM3aUJhd29seHdYbW1BSnhXeXlPbTBNbkpPVFEw?=
 =?utf-8?B?aDRnVGRmd3hXY3hKT00xQnZyc2pJcXdKZ2dUWWs1b0FINEVFd0tKUzUyOVJa?=
 =?utf-8?B?K29ESGx1NFBiVHIwNzA5NlNTQUxnNVl6U21WcnlxV2lKcU5xK2hrVDd0UHhD?=
 =?utf-8?B?RStNYk1VbFZGZjh6UVc0ZHhENnRCOWtrZ056K2owT2x2dlprN1NIZGxvNU9V?=
 =?utf-8?B?cG9vYmxDcUZwbUQzdEt4UTlVeTVKZlJ3YVZBOU5wL2xoYjJkS0VMczZ1eXNy?=
 =?utf-8?B?eERoVXBSTDJaSFQyVFRERVB1bXR0bmZmWGpmcUFYRVRsWEhyb21kaVh4V0ky?=
 =?utf-8?B?eVpXYnJEZ2U5ZkpzZzlBNjNLeWxCWk1uTkdnRy9YZVlOVzhGa3JrWlBhTWlv?=
 =?utf-8?B?ampBZzE1K2RqcHdaRStqN21nMlFRZzZQZDNrMDEzT04vTWo0ZFJpRkVscFZG?=
 =?utf-8?B?alB3RlF6WHY1ODZCRFU5OHRncVNrK2NZUTAzQTlwM1dXZGtFK0M0Q1ZmZ0Z6?=
 =?utf-8?B?Qlgzd3FINHBjZFd2WFdhWXJ0azY3M0I0Z2twcEtmTWNISGExMUg5Um5nWG50?=
 =?utf-8?B?VUZFeDg1a21ZNFlQNjkvZHFsRHVuN2hyUmgvOEswaDhzSUNLVkpDU2doU24x?=
 =?utf-8?B?UmN4U3pLRzVnaVJpMG5RRWtFdHVGd2hVZ2FhR0ZSTVlmMmVJTU9zM2oyOGxu?=
 =?utf-8?B?UW1aa1R4Ri9kS2RMOFhEMTZqSUNQditMVU9SY25OTU5ic2thTGZBb1hxcGpq?=
 =?utf-8?B?enk0UmNQalR4OExMbjZCOXRVVElIdkxRY3ByZlBiMHBFNk05dnlwYTZWamJv?=
 =?utf-8?B?K1NudE9MenpPZElRUVBTbHdBS2JYTGZYdWR6b1ljTUg5ckdzNjNqUVZ5YUkz?=
 =?utf-8?B?bVhEWW9wWXVoVE4waVNQdnN4TTZFT0Z6ZjZrMDRBQmJqQnU3T0JyYVVFM2xi?=
 =?utf-8?B?WE1HZVNaY3NjN3VKNEN6UWI0TWxLeE5aQnE2Y3A1ZVRndGNuNGpmNWFrK3FY?=
 =?utf-8?B?MnpSSDVCYVJ3R2N4UTh1RjRtUGx0U2hkdWM0QmFrdDJTdTkyeFZIL3lhdUtR?=
 =?utf-8?B?clZYTnlORDBoM0FnQkxZMUpuZmtKcVBNaWhYTWtpRGFUcE4xL1Q3VWtNY3c4?=
 =?utf-8?B?L0N4cURCNkdndFowVy9zYTNKZmVhai9QQWZyS3pwWDVzbDB2WWZqNlB5OU9H?=
 =?utf-8?B?cUFlOExCMDVOTVFsUnJhT3ZMZVE5a3h2dlpHVGFXczJZOUY2T25EZFlYaDl1?=
 =?utf-8?B?cnNuT3lMQ1F5RUVKTElwWDBPN0dTOE9MVUJ0WnJtWVE2Kzd0S21hWDA5dFpG?=
 =?utf-8?B?ZHZmUndLL0pFeVg1ZWdrS3BCVlVxWGptTndmNks3QmV6UFYrbXFiUDY4ajhC?=
 =?utf-8?B?RmorbmV2VDNmOXhaMWp6Mi92Z1JoUCtpQzcyM29QY3pveVlRZnA0WXRnVDZS?=
 =?utf-8?B?Y0FTQmV0VUpRckJYOE5UTTNQbXFtc2pWa2lTeW1ZVjJGL1hFemJJdXpybUVa?=
 =?utf-8?B?TnJFdFRFODF3eWtaNGtISm5PdldHM1hleGQ3NnVvRktab2k4M3g2all2UE5u?=
 =?utf-8?B?VVNtSVluNW95dTFSMjFWVDNiOXVTTGJ2N0M4VmFjczUzRlpRU0w3OEdaVzh0?=
 =?utf-8?B?QndpSTQ0UkRVZmpiSDFYL01GTXVzTUMza3JrVWgzWHNwQWpUWW1PaTdqdG81?=
 =?utf-8?B?c2tOM0ZKSkxiTmtSYzdURTZmUUxQVjBrWVlva0ZkREZUanhjRHVUeFRhM3ZF?=
 =?utf-8?B?aUg2SHNUd0RzTFJPM1FNVTdEaHVWWXpURkUyL3N5QlZBVUZjQk1PNTRlVjZq?=
 =?utf-8?B?VHgzeEJEd0I0R0tPK2ltZWNyREhBSnZBRXNjQTRLRjB6SytlSWZhZnFMU1Uv?=
 =?utf-8?B?Mkp4bG9uVHB4ei9YS3RtL0l5czlHMmRpRGdTVnJyMnhjK2JrcE0xSHNzbVNR?=
 =?utf-8?B?WURqN1FlWDlMdENNZHFDRmMrVVpjdjZKOXQxcjlYSjRCeTlpenh4UVIvaFFC?=
 =?utf-8?B?ejlKeVJBSGsvWVJ0V005TTRkZGs1Z3MvR0c3QWI0ZHZvaHVxbGowbEZ6U2hF?=
 =?utf-8?Q?+JR269x/rlSw7QQaq8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cd6d5e-468b-4428-eeb2-08df456d19bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:11:39.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ftz1aHi21c5GQ+MMy06rj9LFXryayS6OkDHJ+NNDCzad2mLmy4CmmpqqXcoP2rzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 18:03, Nickolai Zeldovich wrote:
> On a kexec reboot, radeon leaves the GPU running, and on a system
> without an IOMMU the GPU then writes into the next kernel's memory as
> soon as radeon probes there.
> 
> The PCI core clears bus mastering before the kexec, but the interrupt
> handler (IH) stays enabled, with its ring and write-pointer writeback
> mapped through the old kernel's GART. The new kernel's
> evergreen_mc_program() raises page-flip interrupts before the new GART
> is set up; the GPU holds the IH writes for them while bus mastering is
> off and issues them, to the old kernel's pages, once r600_irq_init()
> sets it again.

Good catch.
 
> Suspend the GPU in radeon_pci_shutdown() on kexec, as PPC64 and Loongson
> already do on every shutdown. Normal shutdown and reboot are unchanged:
> commit 8d13c187c42e ("Revert "drm/radeon: Fix EEH during kexec"")
> removed the same call there because it hung some HD 5770 systems.

Yeah that is clearly not the right approach.

The kexec is often done to switch to a new kernel because the old one has encountered some severe problem, doing a HW suspend in such a situation is not guaranteed to work.

What should be done instead is to fix the initialization order and/or disable GART before the bus mastering is enabled again.

Even without kexec this situation can happen because the PCI reset handling on those HW generations is often not working correctly.

So in situations like VM path through you run into the same problem after a spontaneous reset and there you don't have the change to suspend the HW.

Regards,
Christian.

> 
> Tested on riscv64 with a Radeon HD 6450 by pointing the stale GART at
> canary pages after a kexec: without this patch the page-flip interrupts
> write IH entries into them, with it nothing is written.
> 
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> ---
> 
> Notes:
>     Tested on a Milk-V Pioneer (SG2042, no IOMMU) with a Radeon HD 6450:
>     9 of 9 kexec reboots of patched 7.4-rc3 into itself came up clean, with
>     radeon and the desktop running. Unpatched, kexec boots there
>     intermittently oopsed, logged "BUG: Bad rss-counter state" soon after
>     radeon probed, or hung early in boot.
> 
>     Commit 8d13c187c42e removed this call from every shutdown after two
>     HD 5770 x86 systems hung on shutdown and restart
>     (https://bugzilla.kernel.org/show_bug.cgi?id=205147), but the cause was
>     unclear. Kexec runs the same radeon_suspend_kms() as shutdown and only
>     skips the firmware that follows it. Shutdown and restart end in
>     different firmware paths and both hung, so the hang was more likely in
>     the suspend itself and may recur on kexec on those systems. Also, with
>     this patch the GPU reaches the next kernel in D3hot, so an early console
>     on it (vgacon, efifb) is not decoded until radeon wakes it; PPC64 has
>     done this since 2019, but it is untested on x86.
> 
>     Separately from any hang, I would expect that kexec without this patch
>     would let the GPU corrupt the new kernel's memory on those systems, as
>     it does here. If you prefer to avoid the full suspend, a narrower fix
>     would disable only the IH: clear rdev->ih.enabled and call
>     radeon_irq_set(), which on R600 through CIK turns off the IH ring and
>     all interrupt sources without waiting on the GPU. That skips the code
>     that may have hung, but leaves the CP, DMA, UVD and the old GART set up;
>     they stayed idle in my tests, but nothing stops them.
> 
>     Reproducer (Evergreen register offsets): run it as root after a kexec,
>     with radeon not loaded in the new kernel (modprobe.blacklist=radeon). It
>     points every entry of the old GART, still live in VRAM, at canary pages,
>     so stray GPU writes land there instead of in kernel memory; rewrites the
>     D1-D4 surface addresses to raise page-flip interrupts, as
>     evergreen_mc_program() does; sets bus master, as r600_irq_init() does;
>     and counts the canary bytes the GPU changed. The IH usually holds its
>     writes until bus master is set; in one run of eight it did not wait.
> 
>       gcc -std=c99 -D_GNU_SOURCE -O2 -o ihrepro ihrepro.c
>       echo 0 > /proc/sys/vm/compact_unevictable_allowed   # canaries stay put
>       ./ihrepro
> 
>       old kernel unpatched:  bus master off, IH on, GART on
>                              68 canary bytes written by the GPU
>                              (four 16-byte IH entries, 4-byte write pointer)
>       old kernel patched:    bus master off, IH off, GART off
>                              0 canary bytes written by the GPU
> 
>     #include <fcntl.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <string.h>
>     #include <sys/mman.h>
>     #include <unistd.h>
> 
>     #define DEV "/sys/bus/pci/devices/0000:01:00.0/"
>     #define NPG 1024
> 
>     static void *bar(const char *f)
>     {
>         int fd = open(f, O_RDWR | O_SYNC);
>         off_t sz = lseek(fd, 0, SEEK_END);
>         void *p = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>         return p == MAP_FAILED ? NULL : p;
>     }
> 
>     int main(void)
>     {
>         static const uint32_t crtc[] = { 0x0, 0xc00, 0x9800, 0xa400 };
>         volatile uint32_t *mmio = bar(DEV "resource2");
>         volatile uint64_t *vram = bar(DEV "resource0");
>         int cfg = open(DEV "config", O_RDWR), pm = open("/proc/self/pagemap", O_RDONLY);
>         uint16_t cmd;
> 
>         if (!mmio || !vram || cfg < 0 || pm < 0)
>                 return perror("open"), 1;
>         pread(cfg, &cmd, 2, 4);
>         printf("bus master %s, IH %s, GART %s\n", cmd & 4 ? "on" : "off",
>                mmio[0x3e00 / 4] & 1 ? "on" : "off", mmio[0x1410 / 4] & 1 ? "on" : "off");
> 
>         /* point every GTT page of the old GART table at a canary page */
>         uint8_t *c = mmap(NULL, NPG * 4096, PROT_READ | PROT_WRITE,
>                           MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE | MAP_LOCKED, -1, 0);
>         memset(c, 0xa5, NPG * 4096);
>         volatile uint64_t *pt = vram + ((uint64_t)mmio[0x153c / 4] << 12) / 8;
>         uint64_t flags = pt[0] & 0xfff, n = mmio[0x157c / 4] - mmio[0x155c / 4] + 1;
>         for (uint64_t i = 0; i < n; i++) {
>                 uint64_t e;
>                 pread(pm, &e, 8, ((uintptr_t)(c + (i % NPG) * 4096) / 4096) * 8);
>                 pt[i] = ((e & ((1ULL << 55) - 1)) << 12) | flags;
>         }
>         mmio[0x5480 / 4] = 1;   /* HDP flush */
>         mmio[0x1470 / 4] = 1;   /* GART TLB invalidate */
> 
>         /* raise a page-flip interrupt on each CRTC, then enable bus master */
>         for (int i = 0; i < 4; i++)
>                 mmio[(0x6810 + crtc[i]) / 4] = mmio[(0x6810 + crtc[i]) / 4];
>         sleep(1);
>         cmd |= 4;
>         pwrite(cfg, &cmd, 2, 4);
>         sleep(1);
> 
>         int hits = 0;
>         for (int i = 0; i < NPG * 4096; i++)
>                 hits += c[i] != 0xa5;
>         printf("%d canary bytes written by the GPU\n", hits);
>         return hits != 0;
>     }
> 
>     This patch was written with the help of an AI tool.
> 
>  drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 53d06053dec8..cd786c3264ff 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -31,6 +31,7 @@
> 
>  #include <linux/aperture.h>
>  #include <linux/compat.h>
> +#include <linux/kexec.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
> @@ -379,6 +380,10 @@ radeon_pci_shutdown(struct pci_dev *pdev)
>          * it breaks some other boards.
>          */
>         radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
> +#else
> +       /* Clearing bus master does not stop the IH writing to stale addresses */
> +       if (kexec_is_in_progress())
> +               radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
>  #endif
>  }
> 
> 
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> --
> 2.47.3
> 

