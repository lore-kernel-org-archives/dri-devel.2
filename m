Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A7606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iN0gk4T8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E54A10ED23;
	Sat, 14 Nov 2026 02:26:39 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7A710ED10
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2VyphludgGft4PSiyA0y+THbG0nth0nieQrT5TC/RKM9awzbS8wFGnh6/jj4wgjMqg7br3mDg4d7Ib9AH344ufo7c+hSuJefGyJUY1Km8HAhGTd+NxLbjsqLJgqF4Y0oVpG8+5z0Cnd00e+HEnvfYYDHuPW/VnpfOSLNO7ztSDhrouJRnoUQRv67PEIseF+vegW8smHZ7aRfeXgM6tQIQRc5Wz70631xPDVCjAzLJwEebQBr0RfRe9m2Uy3XlHEZep8fWGikwc7Db5+mWVoV+pXIXuTxMrCBQ1Qhg85tkFqB2FYD1FtqMquvlJSaQjbuv+gnp3OCjf1YdqivYMm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxKTtQfwzBWeOEdsNciUBUjDOX4rrFkj3YM2jcZh260=;
 b=o3XRWZ/dd+OhsMN6zMPKp3GSj12k8vnqa435yglTBD5UnwW1+SRMd4Srfo3vaChUxIG/fMK+uQyaTniVhQ6mZEQf7SvIG1NgzdVPZ0NczxiiHIt8PKUCOoYDwq1asOeBcJXLLQ4F8ZvzE/NIdOF3Mzj9c5QFNLbE+8hQjW0yPMVIcJM3RKNNPdRR+gj96lU5QlQ5SI67zdjHs/B7iksJ96z7rl8cgoazuiuXS3qqnfkJawdpEzJ96cqL3h0WwTvuFjB5cKDXRn3uxpRtsfksozDRdZ89ersRLF1c23HWmvk81uD/Tb5DiXRvyDQ/Y6/WH8peq4ZUqwrmyAUPHX+aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxKTtQfwzBWeOEdsNciUBUjDOX4rrFkj3YM2jcZh260=;
 b=iN0gk4T8UXOxjpKn8FR2C4RH1SC9xscEFd7BtVro5Y1TTxbDFtTOV5NufxQOfASw9n7GxuA2hI1gOOMT3pijWYv2+wKoiABkD6bHuuku3gnP2mJ6Oyug9da59rVointsTJJsPC6Z9tsJvkrusjE5H6TJ1ciOAh04QZCHbaT4+gA2VtRMqAWcFgLA1HIDVAUjLx4Vye6zDEu7U3fpHO9aXP05QVNxjFkNGFcvuA2GHDY7wzZHx6h6zpGpu4c8pr+59lXI+hXdg9m8Ju/lHTiokEOzPsDX0Ur0Qf5WiFdICju43DBgxirTQ2J6Hv42Q1WabGhfDoYo1UM8vcxwcG1MtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 02:25:28 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Sat, 14 Nov 2026
 02:25:27 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 11:24:42 +0900
Message-Id: <DMUKSENZOGWV.1JK3S1KCERE94@nvidia.com>
Cc: <dakr@kernel.org>, <jhubbard@nvidia.com>, <aliceryhl@google.com>,
 <ttabi@nvidia.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] gpu: nova-core: move the debugfs root into the
 module data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20261113075317.934264-1-vladazaharova2018@gmail.com>
 <20261113075317.934264-2-vladazaharova2018@gmail.com>
In-Reply-To: <20261113075317.934264-2-vladazaharova2018@gmail.com>
X-ClientProxiedBy: TYCP286CA0344.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eeb20ce-e8bd-479e-3025-08df41f68b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003|261022075727099003|261028144727099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: +Nk0wql9Nqa73eGI0fuinwyDkcIROZUsW+4hPuJI0HB8XQsKLeqX2gV9LQNyyujhl8VPGhkqWwKyRbIpfRxlAZtEXwYds731sNDP0kfkmfJlB+zGq9ACK6HyKqbzIu27jbJsYfCPVNk3iOFz5VHnb7ArYS2mr4lS7nbiNNcxqTH9gP0LM9Je6S8w6i9vShyltf7kSzUoFCkLMWhW0hH4Z5uDJdBSrKFN91nbkCmd7dEBSr2E4iCYba3JLvu2mdSO96MlXL8lMk1spDnid/YEdTYrETDPfFklwJfjV5rgIfweAD3ANaSLES7Lb5GIlX9k4sU/VtUu1ns7TSSV4DGcV2MJnTQWczhdFwIcxh6EMuYQOudqLLltIogNXMo/2/bR5gW1urORk4r6btFKCxoI0ANt1x2PmGmmeiEhn7R25aJQhF8sKPCl4tp1Syof++AH28ysGqMFiGTv4hpOIp3/eg9y20cFrF51aJ+E8V7Oa13/Yivnpsb4vx0jEQLVy0CQ3Jhp+nRHxwQRHVK6BisuNBcNT3Ha6JL7Ua6b4Mfb8uF8fK1bcU3+H7u5ghF2cxY8AAaf6fGsMcbazoVcQEoZZF/jZ7cG3rpLINrnqcY8vFey/Lk17qfaMbCnENc+tQyJCbz5GyWE1J6rNK0rbb0PGL1JuZPf8DhVUWjL7dw8GrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003)(261022075727099003)(261028144727099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZPN2pZQzBsUncwdmdMTWl0b3ZzKzJJd0Y1dVRNaS9YRnN6QWh2azBaa09m?=
 =?utf-8?B?QXFwVWhNbEJMUVpNQU9NM3RHdXBJNjBvRUFzbWdwTkZNOVBmd3lHUFpKVVMv?=
 =?utf-8?B?dzh0TG9QRlF0b04zRmtYaTl5U0hlNk1PdjQvbXI4cnhuT3hjU0ZNa2tZWDkv?=
 =?utf-8?B?WXg0NUtHQW81ZjA2SXU3WE5Pdm9FWjBrejN3RS9vbmYyVm1lRkplUEE5WjFN?=
 =?utf-8?B?K3JVQU1XL0NqSnphNitWK3M3c2o2T2drY1FKdHdDZitXdG5aMEJDVW44QlZQ?=
 =?utf-8?B?QXlFV2VxR00vVU9LMFpNbnNLVk5sS1plVWx2T2pKZlNPUDFqWHpGVW9DTGVL?=
 =?utf-8?B?K2pDajBMa2NzNG1aSGVXVWc4Q0QwbXp1cDJRTWVPNWFDa1hvNzF3ay9DcFNR?=
 =?utf-8?B?d0tzUm5sbjlpZUhGdm1Db3BoYm52Yi9HSjVDeFl1RmpvL1VUd0lac1BaS0xy?=
 =?utf-8?B?cjUvSzQxdHRjaldEZ2hycVUvbSt4dCtCNDZEOHdkcFl6NG5uUXl2TFpMYzdH?=
 =?utf-8?B?dHhONDIxbXZ4S3F6NEpscnRHTXN2cWc3Y2ZIKzNQVjVEcDNRbTVsVUo3bHBC?=
 =?utf-8?B?Vkd4VitmK2t2YVRZcEpFWnJBMGJPVGFiMHFCdUxKTEUvOEZXNCtnVm03TXRY?=
 =?utf-8?B?aldob2Y5TllVVW5HWUplRkhJa1l5YjVLQXdKbXY5dUdzRXV5OUZ0bkJPV2Jp?=
 =?utf-8?B?cC9seDZod1FlM0VIa1R1VHN1aWE2MXEveU9JbDVIUlNHdUkrTG9YSXUrSitt?=
 =?utf-8?B?aEkyQTQ1VmMzMDROem9ZTml1Y2huRTZCSklXSUFaQ0xIdkVldjUxZW9nWkRZ?=
 =?utf-8?B?ZFEvUHpKb1FsV2lGU1J3VmhxaHEvZmlrT05ERXBFS0JzUEpFWTAza0hNR2ZM?=
 =?utf-8?B?L0NVUHNwZmplbjE0Qno0VXdYTXRqMUdvRCsxMVoyc05QU1hOT0JuT2Z0TUx6?=
 =?utf-8?B?MEl0MWpJcUpJNjNFT05xM0o1dk5DT1daaVlpWDRUaW1WQkpnSmVBNndjSHJU?=
 =?utf-8?B?UWFCOTloeHZqaVdvRStscmgyNnZsTktrUGZvbHJpMXd5V2psNFpGZ2hLeGM5?=
 =?utf-8?B?UXl0RXRiNUwxZWNGV3RVZC9LYytncGZQbkpkTmdLS0hrbWpoQ1FpdkhFbTVV?=
 =?utf-8?B?dnc5aUs4RTNteGtuSDdNd0t1REtIYU1kTEt1V0YzVU16WE9UUklFUjhzd1lq?=
 =?utf-8?B?YUc1aHFhbU1JaVpGSGpiREErQlE0Ly9pYU9UdkJJMDByMkxMTXRQQ3ExTzV4?=
 =?utf-8?B?WjVhVUw5NEhqRWJEUThaZkFjMnZQZXZ1amtsZG1JMUpMeTJRRmM2Rmx5blRz?=
 =?utf-8?B?dnE1M1BXNlA2MUc1bXoxZXhZOHVtaVR4M2Y5Vmk0K3lxVlkrazlMMWxNaFRK?=
 =?utf-8?B?eW9NS3BvbTVFUC9TaXRBYkFDVHZGbW1wQWRxR29vZVFERmRmUzJqUi9oRkFh?=
 =?utf-8?B?YzNObFlRMUw1UGZOTVUvMDFPMFgzWmJVQ0w1VTVOQzI1aUpEa2plb0NPeTY0?=
 =?utf-8?B?ZmFORGZ6ZElSRk5ja2hJRkpOekRUOS9mb0REWEJtSHVLMkRJOFlNTWVqYTNx?=
 =?utf-8?B?NWRkL3pOSE5vM0EvQkt3ek0vcTRZZi9GU3JoOXcrc2VySkhTc28rSzdGNVBW?=
 =?utf-8?B?RW1iaXFLcklOcy9yUW51YUFsTnZqVXJiRUE3bGtybkFvOXNSYzlQSkw3MXRs?=
 =?utf-8?B?VGIwTDhRN2JQY1R1QjlycGhnelF4VkNTMWl1Yko1UWxDNUJET0FsQmtVcWJH?=
 =?utf-8?B?U0ZtS2V1dytLcDllb0dSNWxpQ3JzN2plZXlMZVVMSWo1U1RwVXZWNm9WZkxx?=
 =?utf-8?B?bkRwTklKOEJwZjlGNmF3L05taVhHV0ViSTFoTzhSWWEvRzM1YkRDZEF5a3BG?=
 =?utf-8?B?TWVaRDZ4ZWIvR3VtMDBXMC8yaFFtQ1dNVGx1Tkc2WEE4RXVML3RrbDhVOTdF?=
 =?utf-8?B?SnRGbXY2bXFrTzZvbG9aallBV08vOFVFZHFTZVNTcjhNY1VucnFoajBVNHV3?=
 =?utf-8?B?bDc1d2EwV2wwM0laa1hqR3FObUFMRWFtQUN4amVvT1IyRFpXSXUwMEVpY2ox?=
 =?utf-8?B?NWwzUTdzWVhiajdkNm5YKzJ2LzlIb3NWRFFzS21GcXpKczZqNmVRUE91RUdv?=
 =?utf-8?B?bXdNSjdVR3R6Rk13SllBNW5EbnMxUXJ1N0tVMi9LTVJmRlRZYktLM3QraDNI?=
 =?utf-8?B?eW5HcnVjeDFQME8zVXU1ejJwLzZTMlFLamF0UTFRVnBjTTBBTjdUQWN3Z0xs?=
 =?utf-8?B?SnFnZUdZd2ZaeWZpOFYwTjVwa2ZLSUtDVUZEYlMvbEpoS241RG0xdWtyYnYw?=
 =?utf-8?B?WGVwL3NoWngvS0JWZ3YrSWdDRmhVelpOSkdQYVE3WG1NM0J6eDd0VDZmVmZ3?=
 =?utf-8?Q?bqmaFJiILnYg0Gv9fng19YmGDVwHqI+iV6wXBbNv8YpwD?=
X-MS-Exchange-AntiSpam-MessageData-1: aQDSHVBo/7i4xw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeb20ce-e8bd-479e-3025-08df41f68b97
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 02:25:27.3216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqwrliksLNVFRYRD+xLLzJSNiDFmnOmUOJIPR8jm/x0lxGyPZVkyxR4Sq+uCvsj3XIPMMGRJyPT/yRHMUbhaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 13, 2026 at 4:53 PM JST, Vladislav Zaharov wrote:
> The debugfs root lives in a static that is cleared by a guard field of
> the module data. The guard is built after the driver registration, so if
> the registration fails, the root is never removed and the next module
> load finds the name taken.
>
> Move the root into a DebugfsData owned by the module data, and keep only
> a pointer to it in the static, for devices that cannot reach the module
> data yet. If the registration fails, the root is dropped with the rest
> of the module data.
>
> Fixes: 09691f5d8070 ("gpu: nova-core: create debugfs root in module init"=
)
> Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
