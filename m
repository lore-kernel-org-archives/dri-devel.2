Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CF0CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B47910E270;
	Mon, 15 Jun 2026 08:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yekn71cm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4861B10E270;
 Mon, 15 Jun 2026 08:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6890z4znSpm+8V68MjbbgyGgG4/EYc/QGNuaMz4QrcyrQzd0ZGZfMQsvDeGAqnKU4VdXZq8tmIT6HEWG2kAC2iV8Msq6K8QfaEm9d9MrrG9wrDnmBqwqP4IvDF0QjKztbJjkeKheT8M0VgP9bd9A+M3jjRVUJymxYr/v9gIIU7dqIX1q/KfgP48Fnh9HFlSXXSfO05jxUmqW/PVUShD3UxSJR4VKLjKG6am+i5McaP13KU5MuoGGJCiEOgJ6Ikb52XgXBp/yw+Pmb5ITgQ1DflKg0WFfWGzK5Puuvr6VKOjPHrc2uZ9DM9DlqUxQoO4Qf5C9CH3TKpfTrv9LZEpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpk5CyVWfh/32V1WagtQn7ROD3vv/FvyTtNe0j5wQc0=;
 b=dbuFpCGck/7BlAdX8u+3sEAlqHt6ifA4TdmZh2oBMVZFMe4oP8QwPQq0FUUoVgEmDt5q50EVmKMxWzl5tQllf671IzKQT1+7yUcwipFiU5jElikKD16eRfNkIcJsc7QSXd2PC87yIbOu/dI//eSDvTQ6/k3EJg/fpcHb9NxW9yKUo73itHS/oo5/3pnF2cmS5IQ+fyIoIKHnJ5yPrbhxI4FDjVaD4FVMc49lf/vpp4KGGsD3VMNXlJMO6hPcPPo3UkjUz5alReGqtFNLvAyISqLZz+xaec7YNNdwEwXGAxbjNd8xl47rT38QSnpgOsRyV2CJp8LYCkDqYo93Pj5N8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpk5CyVWfh/32V1WagtQn7ROD3vv/FvyTtNe0j5wQc0=;
 b=Yekn71cmf4wlEck/yiMyBzMMT1GbvdGAi1D1kOWTSYrvhphTIOBodnBrKV1LkTZiyg0npsfvStGS/wOrcTOlWr5NEDxl+IWVmtgir4hnmzP4YTptYz7t69DQAgRClAz5kPejPA0PlTNUZzO2yL9RQipvtlN9MG2QXpvawkyjZWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:12:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 08:12:15 +0000
Message-ID: <3a5ef552-bd49-4a61-97cb-8af395a84de1@amd.com>
Date: Mon, 15 Jun 2026 10:12:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Xe driver asynchronous notification mechanism
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 John Falkowski <john.falkowski@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, LMKL <linux-kernel@vger.kernel.org>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f089b7-548a-43dc-3d25-08decab5cf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o5f2UNQ4AX8ce2NWRtHEoFCSRrUk2XTLvBmk15pJpZiQ9dbH1Z7XqFPcU+CUcyg1hrvictv1NIjXTUgA8db6YJ3DG8kQ9QCX6mcyB5wGgtym69Of1v5YzZbKLm3cQ/f0gw/HTpAtaOEhOlTVhnRveAQbF08Z9lpbmO2AP3n3z+Fm++55MM6N6+9uBDzle/YHlP7UL80ehWEbOslAMybj//SF8Vxk0Bc16ChVWD8GnxmdHK997k7mGfzh6LePdEfp/r5+d9yjNe7nw5LZ5hi5ojL0au/4VfFuABQGh7qRDOEc0GSJTBiun29Lo6gDzVFrAtf7YfUavcaSiJtqnOHgyY2EyAqVh27OEzoAAOodrO0HkoMykFMWTy83H/SOEtzxR2uFSY/HOO3XYxws1ku0UWyy4pzj8YGpZYJDuY1RVUOnnFb0Ks9XqlhQAejOcih56mhUE69awyEZj0lrLTiyV8CDE8KHDmNHpdO1iqrpC/xN0znulxF0Pb+jEcvZQNQFUMbaaw+pE/8i9B7rFWDybGQVihIc9HfVObMh6HQEfheC/V88Ltds6yWtmieMppKU4Yiuss+0QaXdXpSfMFI41cjfDsPdzzPjLML78RjleeHEmIkG4aldJmkcYvgytJ9YEBLA5YOX/PgjpWnUoP2VZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXowNFIzZzFDbVZjNG45NzUvZmI0dlhOeUNiSzlxVlNlRmtPajRBbk92YVNs?=
 =?utf-8?B?OG9CUnV4c3oydzZkcDNpbkYxZEU5elVFRHJSTVdiMWRCbTJxcGdJd0w4bjRQ?=
 =?utf-8?B?Z0t6TXM0VkFJZzQrbU4zV2JPZ3RJZTdtT05pS3RzeXVHSXRIN0E5a0JHKzJG?=
 =?utf-8?B?eldVaFJoVjUrT0dLUGFvdkZFclU3N004K3dpb3hWaHhRdVRGeFRtays2SDlr?=
 =?utf-8?B?U3czOEN2SVBxNVRRMnd4S1orb21oM0xzeHlUQ1N6Rm5Ib0NpU1RndWdmK2Vn?=
 =?utf-8?B?MWI0amp6UFJmUTZUZk5rQy9ycTM5b2IvMjc2UndGWWUxdHJPbjIwQUZHVHpy?=
 =?utf-8?B?Y1hFRVlkTHcrcU5OV3Y4dWRKcEY3VXBNTHFIZjc3bmlOWmVFNmc3Zmw1blhT?=
 =?utf-8?B?cGhaRFRmbXhYYlRHYXNyUTlZdEpuSkRlZTkxM1BoY2xwN3JSb0gvaGhIcDZI?=
 =?utf-8?B?Z0hNTHRGOFhGbjNiWC9rUHk5KzJRT3B6bEhIL3V0eVIxYm4wY0hqRXk2elpP?=
 =?utf-8?B?cVdjU2RBdU9FT2VXWitwRk1FN3MrTUFLUmNQVzZvYTI3MTlQZmYvSGdEbTRK?=
 =?utf-8?B?NnpwVUlONnEvWStnYkNucmprR3Mzc2l5WG5sV2RZU3gxTUIrejVzMkdvVWh0?=
 =?utf-8?B?cmdmWW5tYTNibllLWGpQd1NoS1BRRnltbmFVSitQUU9LQ0k0TkM3V1RpcnJr?=
 =?utf-8?B?RDFLV0lhTnRBNTJGRjViazlMSERxTmxxcC9ISTFXcVFYSkcxUjhNRysyK2or?=
 =?utf-8?B?OVpWaStlRXFZOEFvL3ZNcTk2dklVWE1CUHRyN20xR25OWWNTMzZoZGZwZDRZ?=
 =?utf-8?B?Z09ucmpmYmNQRFNNTHl0Vlo3enRweHoyRHZsb3RtWGRLaWJrVWgwbExCUFBV?=
 =?utf-8?B?SUZvRWtLNGd4K2ZkUU9MajZIcE84R3NzdWpPY3BFQm5OdjEwUGttMzcrcVly?=
 =?utf-8?B?NGo0WWlEU2VadVV1Q3QxNEk4ai9jV3RYRWwzWjZUenQ0SzNDNzVlQWJEMU5k?=
 =?utf-8?B?MXlLSjNDNG4ySHVjbjNOUG9ZS0JmQTdFT2M2cVZsOHV4czZuRENnUDczWjZP?=
 =?utf-8?B?aE41M2dYRnJNQ0FtODZNN2xZV1hkblJUVEZIS3VNOWFHOFNlQjhCZXU3VXlx?=
 =?utf-8?B?S0tucy9ZRnM3NEpXV2tLVGFiQXJKRlZoNWVZZjBsdFZka3J6eVM0L0JSSk1B?=
 =?utf-8?B?eDF1SW14WkpGeFIyOVYzSnEzckoxZDBPRUtsOU93eUZSc3hJOXhwazQ0LzBq?=
 =?utf-8?B?d212WWlYT1VmVS9BazR0a2I3Ynl6RUJ2Y2l1bUlSMFpTZm1XSVd4c3BPSGtZ?=
 =?utf-8?B?UGlpbkRsSTlTNENnbHhWMXVWM0w2QjREYmpTNnNmOHMzV2N4OW1LdEFlQ2U2?=
 =?utf-8?B?a1JCY0ZHVkgwTlRhYXBUMVNLTEpLekJUMzR4d3NuVlp0aGVxVEFjQjNKY3hx?=
 =?utf-8?B?cktrMkxwS1c5ejVDTjNCalU3aWpiZGZLSDVjQ2NoZ0czY3dBUDkxODNLSVJZ?=
 =?utf-8?B?MUpUYlJLSm56bFpzWDJzSTJHVVhDVXEzellkc1VIN3ZWVTRWb3NYVkVFMXRS?=
 =?utf-8?B?Qk0zRlA5UlptZE5jM01FSmJJRWJJU3NtMS9ReXVnWTBlNVVaQUFqaWJxenZw?=
 =?utf-8?B?anFiRVVEVnlKSUluUkdEUHJHTFZNcEo2Mi9rS1B2UGorWTlIVTNtbGNDNy80?=
 =?utf-8?B?RS9aWnJ6RW95NU5BakNwV1hpVzIvM3BjbnFUZ05OZDB2TTFBNjBxZWswSnZj?=
 =?utf-8?B?WE5Td2cvSTVaUW5yTTVrY2o3LzJxa0VxUkdrTEYwTmdSUU5vSEhOdmRBL2VB?=
 =?utf-8?B?TXRTMVVNMUFvZ2MvRlBlL0FEcHNLb1NFa0orMC9XWHdqZnJmMzBjdkhhQ1dN?=
 =?utf-8?B?SUcwUkFGNXhoclhPY3hQUlMzZDhUS09idDZYdko2QWpNaXJQb3ZmbDVKZVdk?=
 =?utf-8?B?NEZldDgzNjVXN2Z2L0krT2tNMS9VdVdwZXdEZU1GQUF3SG1jck9UU3llSzha?=
 =?utf-8?B?WldoeVl3MWNkb3B4TC9oYjRqL3VjV1ZCMHZRRmlGUlNaclZzYnhadWFBcEJz?=
 =?utf-8?B?bnpDcUpGY29zWDhtN3htMUhKdjloN3pWNEF4dW42ZHBmakkvc3hpRlBNNDU3?=
 =?utf-8?B?bmQ2K3lZdk5MVERCaXBBbWxCS0x6djJUVTdFWnJGZWxHQWczWWdWL0hFVkVu?=
 =?utf-8?B?VzJhakxHSzFORHl5Z1Bjd1pQazl0QjdsM254TFRqUWxSVklhNVl6b0ZhL1VI?=
 =?utf-8?B?SnEvMThmeFU0b1ExY0MrMzRKVjQ4WU94NFg5RThxa01ZWXdSTE5rbTVyUmlV?=
 =?utf-8?Q?HpJAmGmPWSfnlBMDNH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f089b7-548a-43dc-3d25-08decab5cf92
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:12:15.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pacWuHA17xJOJ6BJHQ45TaokrpHUcxef5RB4W1TcBuPEuuZ04w7N18S/uhJJJY62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

Hi Thomas, Srini,

Srini is already working quite a while on something similar for amdgpu. We use eventfd and a device specific IOCTL instead of the watch_queue proposed here.

Srini please take a look at this, it is basically the equivalent of our event notification approach for KFD/KGD unification. Maybe we could learn from that and/or have something common for both drivers.

Thanks,
Christian.

On 6/12/26 15:53, Thomas Hellström wrote:
> There is a need to inform user-space clients when a rebind worker
> has ran out of memory so that it can react, adjust its working-set
> and restart the job. This patch series aims to start a discussion
> about the best way to accomplish this.
> 
> The series builds on the core "general notification mechanism" or
> "watch_queue", and attaches a watch queue to each xe drm file.
> 
> The watch_queue is extremely flexible and allows filtering out
> events of interest at the kernel level. There can be multiple
> listeners.
> 
> Patch 1 Implements a restart IOCTL for rebind-workers
>       paused on OOM.
> Patch 2 Adds fault-injection into the rebind worker for
>       testing.
> Patch 3 Adds a DRM_XE_NOTIFY watch_type.
> Patch 4 Implements watch_queue event sending from within
>       xe.
> 
> igt series:
> Test-with: https://patchwork.freedesktop.org/series/168429/
> 
> Compute UMD side is not available yet. Will be available before
> final review.
> 
> Thomas Hellström (4):
>   drm/xe: Add DRM_IOCTL_XE_VM_RESTART IOCTL
>   drm/xe: Add fault injection for rebind worker -ENOSPC
>   watch_queue: Add a DRM_XE_NOTIFY watch type and export init_watch()
>   drm/xe: Add watch_queue-based device event notification
> 
>  MAINTAINERS                          |   1 +
>  drivers/gpu/drm/xe/Kconfig           |   1 +
>  drivers/gpu/drm/xe/Makefile          |   1 +
>  drivers/gpu/drm/xe/xe_debugfs.c      |   4 +-
>  drivers/gpu/drm/xe/xe_device.c       |   8 ++
>  drivers/gpu/drm/xe/xe_device_types.h |   6 ++
>  drivers/gpu/drm/xe/xe_vm.c           | 135 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_vm.h           |  13 ++-
>  drivers/gpu/drm/xe/xe_vm_types.h     |   3 +
>  drivers/gpu/drm/xe/xe_watch_queue.c  | 111 ++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_watch_queue.h  |  20 ++++
>  include/uapi/drm/xe_drm.h            |  91 +++++++++++++++++-
>  include/uapi/drm/xe_drm_events.h     |  62 ++++++++++++
>  include/uapi/linux/watch_queue.h     |   3 +-
>  kernel/watch_queue.c                 |  13 ++-
>  15 files changed, 462 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.c
>  create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.h
>  create mode 100644 include/uapi/drm/xe_drm_events.h
> 

