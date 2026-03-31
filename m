Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B34109B492
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2865010E8E6;
	Tue, 31 Mar 2026 15:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohxYFD76";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD6910E8E6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJJbp5Vaue4goHOo+AQF6Ifc0kq4e9Mi1Wjss0NiKZwHX/8blqM2TUk2Hn6dq4/Vui9Ku+XBRpqBrd+/MVDRpAkj4UxO7H7BVhq0LZYc4hlEX66325R3J4wdpb5vYaAhUqZfR2difbWaUhBxQm4yMbf+yuDuGlVgUU8diqldcD8z3K6kpSQqg8WjVhUEpE5cuooIHcLPtAZ7r72pBanXcHHuYZFSp4LvugcipWwxgr7+cG1Q3EefsTBLcucj0OgkQXFdZZyt8IE4dnwNRXe0FCsl9Go9yGZcDGxoxMf/90hsdFPa6hrCRouDYIAXUVMe5PNZ/6iMcEu9RdW605RLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qekYI9eFqk8fLSIH21urkKKJ4mH33hHfwK0m/r5VKQQ=;
 b=JQm2PS0+HaT6Janr1PAIdqwc+PylWaBZdlhLLDEybaZT/dO9+fYYpYUrIFkZQA3vf0MnwcUD9Ifh5RnzcjDZcLOqyCbpLWx8tD61rzbr8ryqo5vA2a7UMv7+zZIFb8EF4dm8+2vv35Cm1zOLwMA/evKk4f+sp0j5RzN2aW5W+HXDFl6OTvPptNOoqmIkQ9vIZAyBRT7ChCZAU7wQ0Mb5rNgrIM32D2Gvy1fgQTUrF8IfFAz1M0mXpINXJs/GZYectXIRzfWm9vNreWCGmQCLtD7nnwOFjYKGitlzHoG2uHPUaiH3yJvoj8Ygcrz+LImlW81+U0utE1V2mWVK71a7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qekYI9eFqk8fLSIH21urkKKJ4mH33hHfwK0m/r5VKQQ=;
 b=ohxYFD76ON1pZcdAHPiaXKbPUklcD2jFf+AUEZFXAO1gylVJR3UFAeShOSl9nAtWY7JsU4h6CTpAmQMCewCyVK8mpWK1WyZV6eQHS79kD+pS8pCBWyOQz3TrTfrkLKesMQgU1E54ke5rLRz+x8RRjGXvSAOHNmqFWz0OoZHXtLw=
Received: from CH0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:610:e7::14)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 15:53:17 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::63) by CH0PR03CA0219.outlook.office365.com
 (2603:10b6:610:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 15:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 15:53:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 10:53:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 08:53:16 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 10:53:15 -0500
Message-ID: <d677429c-9ed0-5c05-02c3-05a375e46c38@amd.com>
Date: Tue, 31 Mar 2026 08:53:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Add per-process BO memory usage query
 support
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
CC: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>, Max Zhen <max.zhen@amd.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260324163159.2425461-1-lizhi.hou@amd.com>
 <1e573513-b281-4ae3-9140-7a87ee9dab08@amd.com>
 <45bc86ee-cc0f-2b99-f876-9e8861be365e@amd.com>
 <CAP-5=fWFnuZt5CvF--qLfsp6eKkCSUHttCVzp_pzEqT57ZupDw@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAP-5=fWFnuZt5CvF--qLfsp6eKkCSUHttCVzp_pzEqT57ZupDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d734812-bfc6-4e42-3931-08de8f3d9fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: sjhIUqvKZcNVkBDlt0XtQQYWeCFEJVMkS75jBpRcOstxubqzQMMworaWN5o34yMWpw8R0kOQ4L6ogjPN1n+J2/Qk3GZexD4IF+m+aGd2gprOnZM7jEDW/g9n/Wo/MRvzJT2Bdz9vqCAejQTHmS+88PuRxTHxSDjp1/dQUzz2Svnnb5Dad2fv4gESFwfJyw22o3kl9KRUypu+oaf5PEt8uELBIyEMm0M/Urd8sboCWoADfinkuO18bljiKLT2ksfL4wsWFjqzPezq73CuSMaJAesfkrxrEgg551iYvhVQyI4XRmi9rF1RnUkmyvjCMjKWBo3f5ELiTnTZpkjBcs78iFhHQgxmShGLbOrJpQRmSuAh5CTBMFvf2fafBauMP+bW1aRHomb2pEFnl28r0qgKOYB0Iy0rVxSREKvnFu94WZ//tIi7L9sz5gal5goxpwetj+gwv/4sZWFlt/bgj1j2DvYvLC8w8OJIT4ZJWJN0PzARwrCMhwyXlpzY3CV6xI2cY3cAZCi7/V8tJowxDCDpAFnngDR/koUMjBUNhI9kAwamgYFAIvi4A+4m8d3EzJQ9x33hkJbyl8ZFsscvAKDRuK1YJPQoS1dm/QfcQkiPhFyUpuq9CESNfvy3DFlXXpoIwbQGrFVQ3dn6ci8KqARo4T7tXkXyYyT1r7gjDjg/G6GxsnDhudlzTGQvRpO3b74B+sat31/B+a/ka7fHTSv5VtQh2SLcz3CKGpl7OjKVpoDO5TZeYJhc/keNjl2+yKTgy+hEQqs49xTwQl8SsT7uZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: papjhh8DJTc2YCYPdLy+dl6gj1uKD9mN9kpCnecuEtVmo0hAGAQkHIH9RiQRkJe5dVjgzSpiAtz/79iGlKsW3q0rU7wuVkyo+bzjBJ6xRzJHE3zCDdkimma/6QgQzwyNQjKnFQlmbt/RdtpsbitV80MEXJ4vf8RAUJOdcBoc50vGwo9Q/0cVuBT3ktUvVAvUCbf/Z9diEjLKrCj+Albb8edBlJBb14pmw6fECMzo0rx83T5qbFP36JgUKjqyBg567PshhSj5ZKieaqcOVa5BkaCiK22Zvn4zX08KdJ88a4kJBPObUuWaLSjYceq+IzzigpcISoxrX/GfrGN8aTbBoOgUjvDIFO/WhYjbFYLnk9odUFdmY7C5C4RyZu7sdzETmO6GUXO7dLX8HbOWc8rTn2a4qZzGIbJ50hsS4lTm/ckSuQ3Gwh83G7//cKfUMabb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 15:53:16.8715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d734812-bfc6-4e42-3931-08de8f3d9fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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


On 3/30/26 19:30, Ian Rogers wrote:
> On Wed, Mar 25, 2026 at 11:47 AM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> Applied to drm-misc-next.
>>
>> On 3/24/26 10:01, Mario Limonciello wrote:
>>>
>>> On 3/24/26 11:31, Lizhi Hou wrote:
>>>> From: Max Zhen <max.zhen@amd.com>
>>>>
>>>> Add support for querying per-process buffer object (BO) memory
>>>> usage through the amdxdna GET_ARRAY UAPI.
>>>>
>>>> Introduce a new query type, DRM_AMDXDNA_BO_USAGE, along with
>>>> struct amdxdna_drm_bo_usage to report BO memory usage statistics,
>>>> including heap, total, and internal usage.
>>>>
>>>> Track BO memory usage on a per-client basis by maintaining counters
>>>> in GEM open/close and heap allocation/free paths. This ensures the
>>>> reported statistics reflect the current memory footprint of each
>>>> process.
>>>>
>>>> Wire the new query into the GET_ARRAY implementation to expose
>>>> the usage information to userspace.
>>>>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> I'm assuming you also have userspace side ready for this too right?
>>> If you have a link handy can you please include it when committing.
> Sorry for a naive question, would support in procfs be possible?

Do you mean fdinfo? And yes, the fdinfo is in our upstream stack. I will 
post the patch later.

Lizhi

> There's support in perf for displaying DRM usage stat data from there
> [1], for example:
> ```
> $ perf list drm-
>
> List of pre-defined events (to be used in -e or -M):
>
>
> drm:
>   drm-active-stolen-system0
>        [Total memory active in one or more engines. Unit: drm_i915]
>   drm-active-system0
>        [Total memory active in one or more engines. Unit: drm_i915]
>   drm-engine-capacity-video
>        [Engine capacity. Unit: drm_i915]
>   drm-engine-copy
>        [Utilization in ns. Unit: drm_i915]
>   drm-engine-render
>        [Utilization in ns. Unit: drm_i915]
>   drm-engine-video
>        [Utilization in ns. Unit: drm_i915]
>   drm-engine-video-enhance
>        [Utilization in ns. Unit: drm_i915]
>   drm-purgeable-stolen-system0
>        [Size of resident and purgeable memory buffers. Unit: drm_i915]
>   drm-purgeable-system0
>        [Size of resident and purgeable memory buffers. Unit: drm_i915]
>   drm-resident-stolen-system0
>        [Size of resident memory buffers. Unit: drm_i915]
>   drm-resident-system0
>        [Size of resident memory buffers. Unit: drm_i915]
>   drm-shared-stolen-system0
>        [Size of shared memory buffers. Unit: drm_i915]
>   drm-shared-system0
>        [Size of shared memory buffers. Unit: drm_i915]
>   drm-total-stolen-system0
>        [Size of shared and private memory. Unit: drm_i915]
>   drm-total-system0
>        [Size of shared and private memory. Unit: drm_i915]
>
>
> $ perf stat -e drm-engine-render -a sleep 1
>
> Performance counter stats for 'system wide':
>
>    557,542,732,344 ns   drm-engine-render
>
>        1.001575975 seconds time elapsed
> ```
>
> Thanks,
> Ian
>
> [1] https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.com/
