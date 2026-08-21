Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179AFC5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0E910E351;
	Fri, 21 Aug 2026 21:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rHcZUhx1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467B410E351;
 Fri, 21 Aug 2026 21:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Vxk9IcntwyHm47307GxIah71F6Dsgyg25oimRdE0hKQGwT4Y8LZIcJ9384Xu2EpvKdjtZsrckWhjJxu10MnwVj7AfM/HpiyGH8HEXYj4oqh9EKWHW9CKlVgLwZlXkdLJLHeB7heZqgAoY+qRR1POiXfcwTmr6HDa62vmFmfUfHTJITlzuoiGQZIKeHHwMBTX9m06MHwDcAiPTf0CGWZ7xKAgoep7E7FETefAEv+G53F9Cxyq6Q19aI4ubRMq4sACMVf5oqCcAC/I97vakj0I5ogtobREFuPPKD5ipyP7HZMd8zuBp+R1N4lxkFro2w5aiXQGp+ZBbOgRLyaZKCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqScj9HXS8E/1/IZOLATRzKVp9q6ilXY2ZaDCFv1dhA=;
 b=XQn7/SA2f3BB+fspWsnBLyy23gapzxuIBJTzZ4VXNfR1liXYR9sX1SMj0529JaTENAFr7BwCQkCq5BUV1p4gOhhCoZM/HhkaJKfLEod6C7osYrtmT96Hsc0HUqbDOK0zaXC+KTuAiFBFzqIhQsv6PyW3JmhQ9uHVYggDH6dWs6S6jQQi8vSHV46XRBt+kSziPdLEnwRB7otJUD68+c2DHU+SMZKNhNb3imYozVtZT28r2CYXKYh4hgreQxhP9/q188bwQv8Z8XYVs6EuK26oOA2erW+vht13TxhtxYbASRX75oU1hjhY1JMWahOJ1Uoh5g71QDzxoIaBjMON/1Rl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqScj9HXS8E/1/IZOLATRzKVp9q6ilXY2ZaDCFv1dhA=;
 b=rHcZUhx13U9Ivzp3By0yBChLTUTgMrCFWYT8h0cZzs6qLipyzflmYaTSorkr7aCOykpV+ChtghbGc1V0OihVCpmQBjGdLN0BgEAs8yn8pdxXsTVPFJ2db02O4rQbI2unvkXlVn+p8HlDQ/adebbpgwQQsPaB/MVUCc0Ee/aOCVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY5PR12MB6345.namprd12.prod.outlook.com
 (2603:10b6:930:22::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 21:06:05 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 21:06:04 +0000
Message-ID: <48b5b000-81b9-4cd0-9750-ec4ba910d96d@amd.com>
Date: Fri, 21 Aug 2026 17:05:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Documentation: add initial UALink Documentation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20260821195224.809173-1-alexander.deucher@amd.com>
 <20260821195224.809173-4-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260821195224.809173-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 32279327-976d-44e4-51c3-08deffc8035c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: fTdrrTW6GMfYAcNdLYDBcaQ+Pz2pHi4v+8QxPl6ZTwWm2rux/lbunDV6sc5SIcAtrx99G91faBhtBQvB3FQ+wqIlVBzN3etsQ7IBzFs0SUkaTEllqfLFTK2oMi8cyAPUsJxIUxKWXnEyHVeq3emoK8+W8Bo69Z0Q0ZxQi8i5v2sbaDgV9AIh7e9Fs14hmFTP3+KhCGtXj8fuvN12RJOHU/PBuI4AlNpllIXSzBZZphdIXSXMiTUArKV3zfVlYXFGEu+S7wnECAqbyEfsWy+7pI8TKSYEwZztrdBQVeAx2zQsHdzaHSF/lHob/0n42O2flTN7LlJ/+73rjCKQzAO7NOohfG24g5DqjlObewJ/BwfO78Plr67BnCR8soLBhflBRRuMyinO/CZDbc/vQhbwXzDfdF4jHb4g75hUzE00Xp807c0RdF5Vc4jc4KOC+SjChqZvnlebHH0uIbjsULPmtsd8DQgrMdMKbb83AkIQPhD9BWxVSGoeAZAwee2gtVEE0QvuI0pg8QP0VMrymzMpDJn73Sy8BzrMLTLurTArd+sOJB53Rzc/2ULWyle+DQtV9Ck0RluBLOmEyH0mgiMdr7dTlyF3/h6aJ3X2fmh0AeV1l/ErCvqm3NMtmEsHLMMZIoOooQvXm+CSIUd32a04s02wVGoan3lmsVvhLm/JwzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGluQzZKSDQwaUhLdmlUUUhySEFiWHhDZDhvVHVDSld0cU9mSnd4VTM2ZDlq?=
 =?utf-8?B?aVBhdkJuYVkxT3JpWEVNLzZFVjQzNXhPSjVTYkU3aElQalUrT2Rabjk1Q2RT?=
 =?utf-8?B?R1dRdW52K0Zic291b3dPRXQxTVVPUzcrUnVBWTZZeUxIL1VjUlcyb2FBYVlT?=
 =?utf-8?B?TGo1SjNQTi8zK3BKZTUwSzZvRTBHR09VV1AyWTRIRENEcCthQWFmTHc0M0xX?=
 =?utf-8?B?TlpVMUtyTWNIUUZheDg4bExKNUN0ZlZMc1lkYm9PNFEzREp1YjBzMVZhM0pu?=
 =?utf-8?B?bWxqM0U5NWtocFFNaGdYMUs5VXJDQTAwNVFXM3pqYnh5Uk54eTVlL2Qxcnln?=
 =?utf-8?B?R3JtTXhsTWZoUjhvdjNiMXlNTG1kN2g3QklNSG9zcVVmM3Y5UXVQL0FYd3ph?=
 =?utf-8?B?aGdsMyswUVJ3cXphWXFZMnNUZW1iMWVwR2k2TnhsWGE1WFhyeVUrU2M1Sm9z?=
 =?utf-8?B?dGRpa1p3Njd6ZW9oU2dVNWdMd3hWcjJqTTBmbE9IOVZRM0UvOXMwV0pmSjJv?=
 =?utf-8?B?Y2pLZ3FpSE5qVnU0d3dCalhNbFNueGo5VkRsSXc0WXRaY1FKM04zTGo5Zkcv?=
 =?utf-8?B?SzlqcEZlSzZFSlpLRUFueFA3eGl2WlpHYk1rSEdvakV1Uk0rK3FaTkRkeXk5?=
 =?utf-8?B?NTgvYVQrRU5CTEJ3OHlVR2ErMksrZmdBK1FYWXBlaVNIbURTYWltRjF3U3kx?=
 =?utf-8?B?K2dvcEV4OTFTTy9GeHNJcjRoOXZXbEhldUJOUzFBeG93Nmg3VTkvOFQ4ZC9B?=
 =?utf-8?B?Tko0WHpOSWxNajdXR1QzQks4QmFLcU9CWHpGVkRhNFlTbWtxVjJnb0NCQVhh?=
 =?utf-8?B?MGp3dXdWT2FNSXpTbGxnaVBKeWNCZFpFVmpjd2Z2WWthbkFZYURKNU9FWWdZ?=
 =?utf-8?B?cHp1aE0rUjJySWQrMnNJM3ZlRU5TSXFMcTNBSDQvWU5mUzlxSmZtOTZBcm52?=
 =?utf-8?B?YXlWVXVHRVd0WUM0dEVLZkVhd29kVDhFcDF6TGM1aVh5UG10SEx4TEpPMHAz?=
 =?utf-8?B?bFZVc24yblhMUXlhbWxYUHNwd0hnS1RtanYzYzdYaWNTdjhKL0VlaUdrTDJ0?=
 =?utf-8?B?MHBnc2ZEZXBjWXdYY05kUHhGYmFabjFwVjhOTW9saXJKbnhEbXJ0bUJRU01L?=
 =?utf-8?B?ekZ5WTU5R2ZGT2EvZ2pNOHN6MFRmbUVwcDhDUHRldlhXOXJ6TjZ4aWw5eVcy?=
 =?utf-8?B?dm5xaGk0SkQwWWJPSmdtRmdyZHJGb3A3L1E0SkNyWjJuWnFQdExyeE1xSlA5?=
 =?utf-8?B?ZTBQU0d2M0c2VWRpYmh4aGZwUjQzUU9IR1FMR0xLUWhDK0Q2SkhwZjVydnlz?=
 =?utf-8?B?SHRjcGpaUnRNSnQ1US9xOGxOdzVBSXpIQXBsNWpYOU5od0VkUytNNXpKLzFU?=
 =?utf-8?B?V3R1ejFPTmZWQ3pWL1hlMjdXd1Q2cnVJMVlmYkJSb3FKZDlmUTZrS0MxRkhj?=
 =?utf-8?B?Tnc0N0xPM1l2T0Qrd00zeWtRTmM3NzVjR2V5dmZJRDlXdDNBMmNRNkRvNzFo?=
 =?utf-8?B?N0NWdWVSRzJRd0R4aEVzNm1MaHY3NGc2ZHNDUzk2QkJ4SlVNd2VKbVVIeDFY?=
 =?utf-8?B?K2xoRzkrc2F5OVE2U0diSkVSaG1XOHNpeVpSNzFuZ1NnTytuUERaZmttRFNV?=
 =?utf-8?B?YTgvNVpteEpBalFoMHNzL1hrU2x5Z2QxK3RuV0w2c1RhN3BEM2JiK2lGd29T?=
 =?utf-8?B?bVZPSHJHdFg5MHhpZGFjSGJhaHp3dk5yL1BHSGNnaVlvUHNuWVlOMWZSZzFN?=
 =?utf-8?B?dEl5eUY0L1Y3am4rcGY4L0poRStlbnVuREtJa0U2ZkUzYjc4eUtmOWxleFV0?=
 =?utf-8?B?dDA1R09DNkRUM2JRQkcrUVBSdUNWMnBaOExYLzBiQnd4K0oyeDFGRWE4bTVs?=
 =?utf-8?B?amNialZjZElRanNETnBqaFpnbjRqRXNmU1VZaTI1ZjF6VlRQTTNLYVlQQVJB?=
 =?utf-8?B?M3BYQlB0Wkt6aldyYjN4Tld6cXQwenN3K3lZRTR0S01hc0dLNkt3QUN1QVlt?=
 =?utf-8?B?NFBTMVVTek15eFRqUEpTd29ySjZMdWtITTNWOXNxcWRPU2lCRGtMTE1GNzZY?=
 =?utf-8?B?NHJkZFRIZHdmRmc3OWlXZnBpOUxQamtCdWhjMmlydlpEajJud2libW1OdkdF?=
 =?utf-8?B?Tlp4UDhGeWpCUmxMV3oyOXIxOXhtWGI2cis5dUkrVW03Um12eDdTODJBamgv?=
 =?utf-8?B?QkhLUnBJMlFjRVFKWXV0WGlUd0d3dXFKY08yb2lITjQzUFZ3clRtZWpMdmkv?=
 =?utf-8?B?YlN5YW9oT1dvNWlHSG1LaS9JWit5SjVpalZ6d0dYR0JydUp4MFdNZHNSMDZp?=
 =?utf-8?B?akRrUnU5TXVoSnVURTNqUXo1cGREOStXRGUwc1ZBQXJDZjVBd3Rtdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32279327-976d-44e4-51c3-08deffc8035c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 21:06:04.9134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOzA/7YvzELphrBpE2wEAiEvYNfhocgfPn+4xJZ12/6JtFwDXfO/J0oA3ZOaXdlGK7+pCgfwJwJT5HGFyGh2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

On 2026-08-21 15:52, Alex Deucher wrote:
> Document the details of UALink on the GPU.
>
> Cc: Felix.Kuehling@amd.com
> Cc: Joseph.Greathouse@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   Documentation/gpu/amdgpu/index.rst  |  1 +
>   Documentation/gpu/amdgpu/ualink.rst | 74 +++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
>   create mode 100644 Documentation/gpu/amdgpu/ualink.rst
>
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> index b2ab182236efb..ba2ee73278672 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -23,4 +23,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
>      debugfs
>      process-isolation
>      amdgpu-glossary
> +   ualink
>      ptl
> diff --git a/Documentation/gpu/amdgpu/ualink.rst b/Documentation/gpu/amdgpu/ualink.rst
> new file mode 100644
> index 0000000000000..1e0a6c52b7b7a
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/ualink.rst
> @@ -0,0 +1,74 @@
> +==============
> +UALink Support
> +==============
> +
> +Overview
> +========
> +
> +Connected GPUs in a pod can directly access the remove memory on another GPU
> +over UALink.  Unlike RMDA, there is no copy involved; it is direct loads/stores
> +over the fabric.  Shared memory can only be accessed by a remote GPU if the
> +memory was exported and the importer has been authorized. For the memory to be
> +shared, it must be part of a unified physical address space shared between
> +nodes.  This address space is called NPA (Nework Physical Address) space.  This
> +address space is partitioned between the GPUs so that each GPU has its own
> +segment of the address space in which to export its memory.  Each GPU maintains
> +a dedicated set of page tables for their NPA space similar to GPUVM.  Note that
> +this mechanism only allows for GPU access to remote memory.  The remote memory
> +is not CPU accessible.
> +
> +Exported memory is not pinned.  The exporter may need to move memory or make it
> +unavailable to the importers.  This is handled via remote TLB shootdowns on the
> +exporter in the case of TTM evictions or MMU notifiers and remote presense
> +checks with retry on the importer.

This is no longer true. We ended up having to pin exported memory. This 
was also discussed with Christian already. In principle it's similar to 
how DMABufs in VRAM are pinned for RDMA access.

Remote TLB shootdown will only be used when exported memory is freed in 
order to remove access by remote GPUs.


> +
> +To access remote memory, the driver can map NPA addresses into its per process
> +GPUVM page tables just like local memory.  Applications use opaque handles to
> +represent remote memory.  GPUs in a pod communicate with eachother directly to
> +exchange NPA addresses between importers and exporters.  If a node goes offline
> +or is reset, their peers will clean up any remaining refrences that are lost
> +when that happens.

One important point here is, that NPA addresses are exchanged between 
the kernel mode drivers (through the scale-up fabric). NPA addresses are 
never given to user mode.


> +
> +On the importer, the NPA space is like another physical address space. NPA
> +addresses can be used as physical addresses for GPUVM to provide GPU virtual
> +addresses to the memory for processes using the GPU.
> +
> +On the exporter, the NPA space provides a way to expose discontiguous local
> +memory as a contiguous address range for remote GPUs.  This allows the exporter
> +to locally manage the pages mapped into the NPA space.
> +
> +Remote NPAs are managed like another device specific TTM pool similar to
> +doorbells or VRAM, however they cannot be CPU mapped.
> +
> +
> +User Interface
> +==============
> +Two IOCTLs are provided to export and import remote memory.
> +
> +Export Memory
> +-------------
> +To export memory, a UALINK handle must be created for an allocation that can be
> +shared with another node in the pod.  To do this the exporter calls the GEM
> +UALink IOCTL with the GEM handle to the buffer it wants to export.  The IOCTL
> +returns a unique 128 bit handle which can be shared with the remote host.
> +Calling export on the same GEM handle always returns the same UALink handle.
> +The UALink handle is destroyed when the GEM object is freed.

More precisely, the UALink handle is destroyed when the GEM handle count 
reaches 0.

Regards,
   Felix


> +
> +Import Memory
> +-------------
> +To import remote memory, the UALink handle from the remote node must be
> +converted from a UALink handle to a local GEM object which represents the local
> +reference to the NPA space on the importer.  If the memory has already been
> +imported, it just returns a new reference to the existing GEM object.  If not,
> +the importer queries the exporter to get the NPA address.  Once it has that, the
> +importer can create the GEM to represent the NPA space used by the allocation.
> +The GEM object is then exported to the caller as a dma-buf. The dma-buf is
> +leveraged for dynamic attachment which provides the ability to revoke access
> +when necessary.
> +
> +
> +Device to Device Communications
> +===============================
> +
> +Devices communicate via a protocol implemented in firmware.  Mesages sent to a
> +remote node generate an interrupt on that node for servicing.
