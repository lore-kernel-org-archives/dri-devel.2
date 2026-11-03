Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1631606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kJJ9WlZk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE59910F2F4;
	Tue,  3 Nov 2026 00:47:54 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FED110E701
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 00:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c84BtPfpIRrTUr8I4WjWAQicfJd9GZNYbLFFBv1RkOuS6DF2nK+3bR/UirndaGxJ6EQhQzpPVANdmYq2K0LEnpZGFk1YYcjE+yDX0RQx2BMfxV6kHf82HOWgK7WJ7jf5il6TscfdXbaBs5bc3GdhDYLsMHbzFwlam+IXae4glCEPPUDCkCYGOQs4/uX6I7hY21xfSisFNr5AAYXzcWLi54MMp6FMtTrsFZeU2N5GaAh5XzGOq0b9w3S6kHDZDvJMdYK1yOocyCUZSTKTOqz2AxGQfUoOqZOAGVj3bqWYKNsL1bJdalkxpXkM9coGmC77xyvriGfaAm+iiSSqFNOquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9bfBYyQOvNV66+ne+FMtTK1VZVHMtDO2YfSCjC1AyE=;
 b=JC30VE1uhXglfvIAcmh1R8Nw8cImrCy4Vt/3W8kylyzwLEr2nB7gtS2eFndiJl0xh+xKgsWQ2fcyEZshAj7NfFJ4dNf7tySUZ4b0wXaq4KAUKWcTxtMB/Vk6qOWAG8BVEtRNYZc4/o5TAlJq6Luk1Dj9Xposd/yDA7yOrkJB3OMBVIgPbJX1qIH08S/NA2/DcPYU1quSyRzxdJlIiBnFvkSpGmF6kIyeJzbkTB9+mqf2nuCdELEobX7jmnkNIi6vgxidnHvFl+ikGE8QAWdyePaZ6+gYpmYQp2f/dKdptJjwO6AIYu7v6bB5GU687fR/tou5q0PNdi28k/eBvciBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9bfBYyQOvNV66+ne+FMtTK1VZVHMtDO2YfSCjC1AyE=;
 b=kJJ9WlZkkZuVybsFwLkz8NkdkduojCA3c8f26hxJ7HLXkRdb6U2RVB863w7PQj6iIxS8WVfUeTt9vKHUAH+hLBX1pXRjARFIKWjyjHORo7e7zv+6JF9peRwEPoeeYNP+Imi+i7lXtm70mUmzWlix8P0A6VXlucTpNxhRY8txBgHr5m+xsDJjRQ+CpoaYGxtQL2/SH2W3R0LT3O7rpffhBiKWlPfsTzabL0Cye+5TLaRKzq0U1n8+CQKfnRcAlYCVAVlFuVcePQmQXf9RzR9kgJBDB+LxQq4zqgGnsul1IDXAAGWcMtpMD8PeLeysvyDd/G5YHdmNAfAaRkG8eLC36w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 00:47:40 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 00:47:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 09:47:35 +0900
Message-Id: <DML5U1TLCIEV.1XRE244JV8BBF@nvidia.com>
Cc: <dri-devel@lists.freedesktop.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <lyude@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/shmem_helper: Fix kernel-doc name of
 __drm_gem_shmem_free_sgt_locked
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Ravin Chokshi" <ravin.chokshi@gmail.com>
References: <20261101153000.20839-1-ravin.chokshi@gmail.com>
In-Reply-To: <20261101153000.20839-1-ravin.chokshi@gmail.com>
X-ClientProxiedBy: OS0PR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:604:1c5::7) To PH7PR12MB6858.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: fc22355f-cc78-4159-ebb6-08df39440f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|10067099003|11063799006|261009223027099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: n8x1cIgSXoShxBXAv4QlAep91CWRptJwqhea4gqOcipLoVbvtmtJdfgRXWgVn/Bh71XZIjJ2jsdzTg0GD6eaCx4kj+dOK+ThcC5+yfbVRKG+DnC7FemUiWEf8dmD+QLpOx2BBX5lB65Ys47ltVYkmxF8BIV2Q7ALvrQpd0V6ilE2HSKhjWG/b+NNKXJqEkTkspQkhj2zv5cugn8yR+D8r2l9k0uDeF8KyFLeaZ34XHWh2LENYkSa6The0URb/0ZyYizybBNxhUDExOvRfaaOOvFyMzkPJ0bqA75jOYBuWcTlfvQzEhikd1I6ryRCABJkYXuGOZhavwQQ8DrEERS8mEUFeQSpz5ob8wuHIcNaCNXR/24Q9mZ9TM04QMg14f3cnOwWG2f+/8/MNwtNG+UbbizDtnESAn9XzyKie+VtTuX2mducFYYMYxN2+gF8PfeQn5vYskv2ls+L7AV96cagXDyK5ACluxzA/wFUs5wvxYUV8HhCIdVO3vcLKXTby5lSR42c22tv/SeLV1xRtig4sMHfen/E3Zj6bEKTPDqTMAgEdLhQelgnAUDWWw2YPhX4cbAsLgP/vcUKVS1+btzrMqPeY3fvdoq6M2PIt2jJAxkCQS4LEs97G4/3QStS1u5zbShOyMA1cyVJFrAoFJIqCJInwVMjp9n+LucvEHSgSzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(10067099003)(11063799006)(261009223027099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHgydVFpcU9abDZBUWpJNXNGUERkUm1yTEkxV2FqT295Z1FiVlVrTjdjeHZW?=
 =?utf-8?B?ZkVWNUJBQ2RtRUhMNHp1YnlPWGU2azVadVdLZkNpcSt4R09NTXVqNk5KcDB6?=
 =?utf-8?B?UVJ1R2J0a3JYc3VEUisrMDgrL21LWjBEcStaMHBnaTB3K0t0cmlweHJ4aVJW?=
 =?utf-8?B?QXg2M3B1TmpLZ3BEaHhFMC9Ic1hXUDdsUnBJcS9PdmxvYTRHcVE0cVp2dTRw?=
 =?utf-8?B?ODN3YzZ5RDVEbG5LeDJnR3gvTWh1S0J5ZWxTVVBCc1pkb0U0MVl4MDVJdjRz?=
 =?utf-8?B?MHE4Nmd5RG1odUVFUmF5YmkwY3drc2NmZnRucUxwYUlaWERyMjVpVnNoNzdS?=
 =?utf-8?B?S2NtWXJ1UHdwQ0JDUkFYZDB4VnhPL1huYXBwQ1hpaGs3ekw4TEVKVlRBM1BP?=
 =?utf-8?B?SDJUZlIyZmRMMkc5NlBweHI0cnJZdkZMaU1wK1RrbXZQeDJkTTBwRTlsZ1Bh?=
 =?utf-8?B?UmRlaFpZTXZUTm9pcVVBWlZvcklESDh0QXJrcTZKUEd6Z0FXcGJXWXlNNDBq?=
 =?utf-8?B?bkk0UC9ER2tINDFvOHdtWi9nbzRDUEIvVHlxVjVPdlVMNGZXQ0hRSmlRZElY?=
 =?utf-8?B?b2swWkVNSnlvMGEwaUliRis4Tm15TE9OUHo2cUZBbU82NlFaQ1R0WkhwSUZw?=
 =?utf-8?B?ZjJYU24vc29POVMzaUI2WUlSV0M1dTZHQ1JjMXJzN21IWDVCVVlkQmtGcTZO?=
 =?utf-8?B?TE5xcDJTK3h3SUszS0UrdXZsUXFFNzRYLys0VzlhTFRyUXZQREp6eUZ0WmdL?=
 =?utf-8?B?OTgvT0NLdGlqRk94R3dIWnpTVmNpY3I0dE5PUE90czc1eEVoTWdIQVgxOUNm?=
 =?utf-8?B?MWNVekN3K0ZBeW84cHhBMjQvUWpkVUJmUlRaTjAyZi94U1IrT1ltMGFvOEtQ?=
 =?utf-8?B?bElGR1RjNEQzUzdJS1ZNek5mdE9TVWtUUER0eWxaSFlKOWpEaGh2V3d4NzRN?=
 =?utf-8?B?NVEwZitTZnhSNDJOVjduK2x3aHdVdVdXOUNWZG1lbnVxa2JuN0R5MW9Sd3dh?=
 =?utf-8?B?UGRRaXBjdGtNd0ZuZnNZQ2RMd2o3TlkrSXFkMjhsZEdLOGc2dS9yaW04L3RU?=
 =?utf-8?B?cCs0QXBkQ1NSU05xaEw4NDA1NmZGdWNiR21pMG1rQ1ZEdEZEQWhReGVvMHVJ?=
 =?utf-8?B?ZERSNGUvaTNscVQ5d1gvOThySzFYcWhXVFFZaU02MFd1enQ0bUJ1YUFaVXY3?=
 =?utf-8?B?WmNOSkY3NU5HdFNUU2NPVzZKY2lUSnpCanJMRldtbjJ1ZkhFN2RXWW1ZUDJI?=
 =?utf-8?B?VVk4THlhcEZ4WG4vYk5nRkNMNUFQbmltUWM4ZEUrRnFIa1NMWHQ0NStXenoz?=
 =?utf-8?B?TG50SnBEcy9qOHJHREdrRlh4QkhBMFd3aGRyOW5vWGVyMUlKei84b1g2UHRn?=
 =?utf-8?B?Q05yRWpmeEpUSy9pODZmR09mTHo5eTNVemVORVN3SjBzSytJVDVZdFkwcERL?=
 =?utf-8?B?ZjVyNEZVOTRwM00zT1h4RHpZYm5Va2xaSFFoVEVxMTZxQWhjRVlaQ0cvWjRk?=
 =?utf-8?B?blRVRllhTDNEVnRCTlRUZmx4a2swbkVGRGhkMFM3T3l6bGliYnVSYzF5Q2Nh?=
 =?utf-8?B?VlRHTlpReitRZ0Ryb0ZxbDhiODNDSXN4WU5FNDFZM2RlU1RPMlkvMVNNeEU3?=
 =?utf-8?B?eGJ0bUJBQkpBTDlKUGd1V2cxbVB0bFljSVNPbzJ0a1Q0TlNrdDNkZlBTYUNx?=
 =?utf-8?B?ZU52a3Myd2lvU0VIVWJvMy9KakwwdEdHZzZiSHRONE5PaG9ITmdvL09uam1l?=
 =?utf-8?B?dG5tYmFRMDRWWDhFT05YYnVJcCtXRW5nUmlZT3l1NTBxbU1saTk5MkY1TUNX?=
 =?utf-8?B?dDNFRTkwekUxdDZFZTZnM21LQkV5d1NQUkpJdkttYlBsWkNFYWY4WWRoMDdX?=
 =?utf-8?B?T2FWRjhYWFhjYmtTSHNwc05uTkg1UFB4UW80dlVYMXlOalJQeVp0S3lzejRj?=
 =?utf-8?B?YThZM2dQcmRZL3hzd2swdlNvTFFURlpnSmU0NnpvazhjdVJUWVJaZmwrZndY?=
 =?utf-8?B?T2VKbE5kNS9McFlUa0FqeFAvZEp0TDBpdkJZMUNESE9LdEdQRW9hNnVweFF6?=
 =?utf-8?B?ZVlkU055Y0p3TXpjWU9mc0FtV2k4RmptbkV2RncwdE93VDJiM1JFSVFnU1Rh?=
 =?utf-8?B?UGlTbURhcXpyZWluaEh1cmNFa2h3ZHE1ZFh5SFgvMHA2V2ovSFdpOS8yY29S?=
 =?utf-8?B?SS93NVY0WUxvYlVNaUxjNkViMXBLTHFldCtlU0dJZUFNSWZTNFdZMmZOb3BV?=
 =?utf-8?B?KzdRaTBVT2RmKzc1NngzdG5ZTEhrUlZrWjVFemNzN002ZHZTQUZoc2hZQXNT?=
 =?utf-8?B?NlJEaGYzdlgvSnBiWXRKS2RobjhEYWpZanZreVh0ZVhQT0gzQXFSREFvQ2o2?=
 =?utf-8?Q?gAGY6G3IEQnXe+b/K/04cMYgaB3olblxeb5wDLnjpdEee?=
X-MS-Exchange-AntiSpam-MessageData-1: AAnFDEa/v6gkFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc22355f-cc78-4159-ebb6-08df39440f53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 00:47:39.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqjvCHGFqggMi6TVLOjCFD+UCvItKNfoMKbMyPu57w2/OlCXaxxNYFWh8vapVq3K98aNLXl+DLJ0pYQ9f6rZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
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

On Mon Nov 2, 2026 at 12:30 AM JST, Ravin Chokshi wrote:
> The kernel-doc comment names __drm_gem_shmem_release_sgt_locked(),
> but the function it describes is __drm_gem_shmem_free_sgt_locked().
> Update the comment to use the real name, which also fixes the
> kernel-doc warning about the prototype not matching.
>
> Fixes: b78dab829760 ("drm/gem/shmem: Introduce __drm_gem_shmem_free_sgt_l=
ocked()")
> Signed-off-by: Ravin Chokshi <ravin.chokshi@gmail.com>

This is a duplicate of a patch I sent a while back [1].

[1] https://lore.kernel.org/all/20260622-b4-gem_shmem_free_doc-v1-1-85496c5=
97b18@nvidia.com/
