Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82ABC88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 01:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF2010E7C0;
	Sun, 13 Sep 2026 01:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iW6578AP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB2A10E7C0;
 Sun, 13 Sep 2026 01:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdyZYrrlcHX6AR/yJ6/ihSJphB5JVDG9ZUvUsPwxMmSYutz0PDXw7nfVV2/qdUK9/qcMMDQzsEt1J+sgCWtfOLFneAMzW0utLnLbpDnZuDBT2rJzXBOISHGkNVd2kTpk30CQX31M4jkVFAH1FgnuIJAit0dfES91aHeb70HD8PpwfEA/AXF+n7RAL5yXGAkUBtpy+0H2TAw8oSQI6qGwzW7g60NvXSyEZaOXd9LkYochJ13FsKqeEC35S2V8rwTp+CmZhxnqWDklNT4/Yy3RZQWmyKOe7waNM5ilQLp5ENG8PvZ/zPufHdhD5PYYN/472ylcW7sFLinQcIkg/6Dl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62aqsPsKMyYPT3UJQnLu06R91pBTfXUxahzxRhf25eI=;
 b=fE2dI8ngANXgQ1bf/mURvuMhfvAFFiccsc+eqXES8WofWke32UtQFLruy8q1DgvAfcoqTJjGMkyLeeUNIcdO8+yIDRBNdv36bks9ttSsxzlZMuTV5LxCJ+eZhdXd68qoL1mwIebc50NqLbtnDpV2ASXDfTrLQ8N7kAG/dT0deUm86DJnmodzOEs6fEIHWg4KbOCXnD0PF/O74JnXHODixuAisa77C8nIoEp+iijy3qT00N/8rU69VT1QCgGSY9/bgKbKE2JxChCxaZKwnECDsXWPfEYKrzHIS7uhwB9viahyu+BDxNB3OGB3c4knuyONmpUIMeEUmcbuq5ELzDB2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62aqsPsKMyYPT3UJQnLu06R91pBTfXUxahzxRhf25eI=;
 b=iW6578APuoOFPeroLyzpRoGjP/oM8S3oFhTvBWRdP7QBXwvgYl/6KbvyVsrO4cqZrHb3/w0o4mtxzWYwN1XGio9MC9NyZbJnOAJI6naU9FE4s15j3VA3+O46atsb/KXBpILtRM7Q+HE4yZ8xiQu6TJ53dVdgddJ4rp+hSIa+l71PKySVnCMmCM7LoM0iZg0/ZvYBCmsKmOsRtEwYPy1NPQfZliLfEnx9EcT+7cvKhhKKNSdPedsuhaSOmEjxArT5MD4XWsM/aSljs2EjYXNtAlPMeAXp9YI6Sz8c9hLZnOCXvmSpxcuQqBfZCT9LAdseXgoMpTASL9VjIz9QgmGrCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sun, 13 Sep
 2026 01:49:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 01:49:34 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260909135319.1364776-3-manuelebnerli@mailbox.org>
References: <20260909135319.1364776-3-manuelebnerli@mailbox.org>
Subject: Re: [PATCH] Documentation nova: Fix bracket
Message-Id: <178926409105.163129.8548017144804296465.b4-ty@b4>
Date: Sun, 13 Sep 2026 10:48:11 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 076168cd-d66b-45cd-9aa0-08df113942fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TsEDllIkajLLedWgnlfVxTe1B6BkSVfIgYOfOnqxY5+Aj2/hMe5YDq9N9JJiQbFWOii8O4w0DCcg4zqLERb9ZtQnDS9dWMhdOP9Gc/OWoLxIjmTjFzVjbkhBCxvLk/gTsaf7a8xHdj3HpXQR/YQpWlVo+2QEmNUQVBXNcWfUPb9T2Z2njkZmFWQ9e8e6Qn3NTzZa9eT06+jLchbEH4z1LJCiO0rPgsz4nY9+kcLChYGh0HqjSrwRV0ccoNv22mCyoXHPlZpWTEpzQyhJpO0ZVOqWk7kTXkfXT5xYbMufAU7iIJ5AMONbriu5LavV5zoo/LCMd1kZYj9cnTwibEmFee6OR4lzbrOSvIwFbA+EaIGMQtFqw0HpZeadLmKWoS1IUMgoa4Nv6iWtqdE4aohSNALcjU2wwFi8PD8z6go/nGdhXhainoiVUnaOPHdRfF6Yf/MD5afdEvLQAf9lpiHHRNV5M9uGBNkatLxb8c/iIOSft7AatAGcib1ny/EyyyfkGUK9J/BzA746t9rFQHr2WduoKl6nNRVsPg7Gebw5AnTPv+JlmxQyI5mmxxaccjHVf8fBueuct51QX7suX5DZS8Azwvz4JkQWXjXpEhozVihrBo56G+0fwVVmEWD+X1qqK+5KM5hRJbhPkHY6WFuBWo8AJywDI95xlZIEs5W3HPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVPbm9ZcnNyVmRqcGxYUmRrUEJMSEl5R1Irci9UM3d3c2RnZ1RmMnVDdXlP?=
 =?utf-8?B?V3lxSjZleGxRL1lTemV5R2I3ZmFpbE5UYkw1WXNMUmdMeXZLY3daVGNRMjI3?=
 =?utf-8?B?a05wR1Izck1tSnVta3RKVFZxRHFKamMwOXdZbGVseE5sajA2QndFc2dlbGNP?=
 =?utf-8?B?SytwT1BGcmttVzNKUW9FRkg4aG9qclFLSG5Pd2NqUzJ1YTN4emxTN0ZVN2hs?=
 =?utf-8?B?VVRwbkpzWk1MeUM0OVVaVVc3SlV2V3NicGo0bGJRREVjWDNLbEhGYkM0aW9i?=
 =?utf-8?B?ZHdOK091QmZyTGxkTmJsalFoWksyQXgyUzBRdldReW11dVdNaG4zQ1d1VDR1?=
 =?utf-8?B?Z3pRR2VzT2ZqMmc5eVRsNEsrSE1pQUt3WkRrbkJNNm8rZHA1cXN6ZGJTdzJa?=
 =?utf-8?B?NFJyekVwa085eTFqU09KSlhYTHlNZVNPaHV3OUhNV1JxZmxrekwxSVpZQjZm?=
 =?utf-8?B?a0pJYVlIS0crNFVNTmhMM2Vla3dacVZJdXErNEFlb3pSS3d4dC9WS0hYRVVI?=
 =?utf-8?B?emtjSTR0ZEVuTUdGRTV1OVVHeWNUbnk5Um04TnlGQk5iUWljb3hrNmlkM2Jy?=
 =?utf-8?B?anZLMzR3ejdGMVZva1pqNjZNb1pwWTVNT09XVFplL0h0enVKWTl4OXcrNGs0?=
 =?utf-8?B?NXhGQ0RjU1JMRnd1ci9YRm5rbEgwOGNoQ29tMi9wTDVnZzdvUld6eUdXS1g2?=
 =?utf-8?B?YXEwQ25XR09QMUs3cVE3eUp1c045QlBXU3RGMUo2dEJQa3BNNGJncjRVdit3?=
 =?utf-8?B?L2ttT2pIT2dlMnZSbHlVM2E5cUF2K3dxaUtUZTY5cm5pOWcxMEdGdStZZHdn?=
 =?utf-8?B?b1diMEgvSUdUbXAyM0dBUFVCZ0xEbVBiTmtaVkRKNHZNZHN2QXdZdU9tZkcz?=
 =?utf-8?B?V3hWSzQyR2RjdHo0QWdWWWdDTmhXZU1CSzIxcm4vc1dTMXNNajV2aVFUcW5P?=
 =?utf-8?B?N1oxYklwWVFPVGVoL3NSd0JaNkNVQVRpVzAyeVdsT21QM1NxbHM0OVUrb3Ny?=
 =?utf-8?B?UzFtYWVOdzVOaFRRcmZselliN0oxMGo3Z3RKUTR6TmdPUGFscU9JcDlJbmZz?=
 =?utf-8?B?WjArR2ZHY2M2eE5VYkM3ZHBxS0JGU2J2cmdNK3VvUWxSMndBSGJqc1p0eHRN?=
 =?utf-8?B?dGJJa05SQlZEUmZua3l6V1BubTNHMVpoeDEvQWNQdVV4TDVWYmlueXVUeVVI?=
 =?utf-8?B?L3E3WFpGQmRnc09hTEZ1akhBNE1zY0Z5ZkJYUkxqbmYyYnhIdG9DWlg2Y3gz?=
 =?utf-8?B?dFFxajhzK1paalM0NllFQ1lEZUNPQjdCb3VieDR1eHRpUVpsWWVwWVllM29L?=
 =?utf-8?B?TTNobFNXcXV0MTN5K3RQaGUxVzJLb0k1UkpvbjlkWm5ra0I1YnNEWFNFZjBx?=
 =?utf-8?B?cFVQdlJ1UHJHMG1IVXhLM3hoZFYxVmxwdFJWMW12MTZXQmRYT0N4RnZ2R2xw?=
 =?utf-8?B?bjZYRVRXSGhDN0hCQiszTC92Sm1uTUt0SVBYR05RWG14cnEwNDhxWHRuNTQ3?=
 =?utf-8?B?Y1J3UDUvb3UvTHhvMjNxTWlGSytrYkJDRlp4THVtb25Ed3g1djBiOVFEbm5j?=
 =?utf-8?B?aHUzZVVVcGNtVEo1TTRydmhWb2lRSFgyNkh2Qkx6WFlET1IwbFY2aUxReEp4?=
 =?utf-8?B?ZEZTMEZmNnJpZmtHc2NaSjhxazJVSWVnT3lWemwwSll0Uk5IZzhhdm9OTTdk?=
 =?utf-8?B?elhncmVkaUR5a2F6K2FzaEFnMFBUdnNtckRHMThEY0dmSU8wc2t1MUxpSHZw?=
 =?utf-8?B?VTl3cHFsYnFVRXNSWWxmQTNpbDZJKzBHMFVFTmRqQk1YTjBYYUdjS0FkQlp4?=
 =?utf-8?B?SXlTanplNWR6aUc2ZkI1aTJTaGJ3bVlhclh3SEkxekdzRjFwL20rNTJiTnVQ?=
 =?utf-8?B?M3pQdnA4MUdRTE0rQi9EY1VkTml6T2pYTStmUytHQ2tqL0l3S2wyTEM1MU5G?=
 =?utf-8?B?c2lCTmM4eUl6VlZPeFpDejczcFNPTHV1Y0NNS1lJSWxMTHZxVDVRdTQzSWtE?=
 =?utf-8?B?OVdwb0lpdWpLb0U4SmtCdk1YWlpXRk1hZkN5MENhZ2xva1BNUC9pbkVJdy9L?=
 =?utf-8?B?ZTNLVnVzUVhxUDdNWFZFZE1UakNNckpJWDV6VHAzcThYbUg2T3Ywd3UwRnln?=
 =?utf-8?B?UGNidSs3YlJpUzVYV1AzRm1CenRkWTBwYmNnUUdDU094KzY4YVpHQWIwZGhU?=
 =?utf-8?B?UElUK05IdkI4Q3RXbzlUS3paaXVaK3NKSGZpbHdNNjhFR1lBa1BiLzRLb0g3?=
 =?utf-8?B?TUw3ckNzNU9zL0NDT1I1alBBcGpMNzJEYTBQdm1ScG13OEFzalk4Q1c1cUFC?=
 =?utf-8?B?WndtelF2bGltNEI3UjJxbFN4MGVnbXdaV3FPV0M3cWZTZGkrakdkZmQvOUtH?=
 =?utf-8?Q?/Yxu08Qo03MR57KBMfDjCvJJbtcMMX5IUsr/bIEK64nT+?=
X-MS-Exchange-AntiSpam-MessageData-1: ApBr0RbsC7aMCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076168cd-d66b-45cd-9aa0-08df113942fa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 01:49:34.5679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdDXCJE0LZ7NOv1K97Ft6YVSqWD5LJoc+A2U5xA7m2Hz9penyGqkdZjpHqUqpSkuUZ7Chjk9WIr71Lsu7Q96KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
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

On Wed, 09 Sep 2026 15:53:19 +0200, Manuel Ebner wrote:
> Add missing ')'.

Applied to drm-rust-next, thanks!

[1/1] Documentation nova: Fix bracket
[acourbot: add missing `:` in commit title]
      commit: 66a2c223b620d844fe26c6bd4844d2a6a8c9dffc
