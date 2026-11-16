Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223B606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wGKV2BvS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF65710EDA0;
	Mon, 16 Nov 2026 09:55:22 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B50C10EDA0;
 Mon, 16 Nov 2026 09:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBZQ8Y/ILdScorXA8jwV9GQGfScaNTwrabc19ehThLGduLEomhfTOBfcqi7vrhGVkNzA/TJjKem00/Qtzy0iNSuaPO6HOBHB7SqMV58PxwfWs6twdiOjOXgw9Oq67gBjCBcQQXPO+hFoAE45pDSyMK34afjfWEK1jCkgU3MTWA8OWVntIs48RDICeZmSE0Ax0mef5zzO7QJroIIHnNh2lXUkGVhY/kke25vUpXEKLHipM17bxdy2laxid76vSZmgvdVybHOd/1vEQ1pfHTJDvfb6/sDA6BfBBxTNLp4jJ8tTPsK/8NqPem8wnLe7NojEd39QaQuOt0NqsZAVqigwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mmra2b3KAs5paA2GebNI2nC0VtOhhvGnxxhmUWZgXY=;
 b=xs/0aP1l87J45liGj8B85uYsuDrkdz6enOmD5coqAC2jpXZx+NDiWkTavtXmBfHqi0vnE6v9H1Ax6hI+6vAtU3hOJvaWeeMOO/drE1rillPQpCRgtHPPkuf5gsiqU5C1Ffp9sQ7Xa9ik7hMmJ02CcQHPe1AqchY5NItoB7pbuudxiDMw1K4SDO/gvkxChFc62Glg+F7eMa+iebE/dKi3NJgc+Pn0aXWB+0SwazqtXhPGaC1Iz6nH+38FQGwYYGTfslhEADi+0YydbL14hOYIC9LfLhYS6MRX82HJSLWdG2dYcBKt4WzylhbkvrgX54+BeSIzRyBlxr7squ6mEVxvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mmra2b3KAs5paA2GebNI2nC0VtOhhvGnxxhmUWZgXY=;
 b=wGKV2BvSeJExS6uYPjP4466QCgNiHdD3Sfr4guIy79c4SfLauJSlz0g6flSi9w2DDROa1UQL1Z4qFI9cmTMiliOl1oahHx4XlTgJzSu7uwmO/8bXiP5A+piKQLyFmZ/n4D1uAjIpuS9OCWbJ0uur/YgA4jdGdDsOAdJzRgkpjHA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:55:12 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:55:12 +0000
Message-ID: <ffbea2f6-c2d1-4e61-9e58-fc458d7abf0d@amd.com>
Date: Mon, 16 Nov 2026 17:55:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: use atomic commit for panel power
 savings
To: shivamkalra98@zohomail.in, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 Alex Hung <alex.hung@amd.com>, Hugo Sales <hugo@hsal.es>
References: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 071d1db7-5edd-4c73-b557-08df43c7b4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: V0dy4aeKHGn5ODAp96w203ISIIS9cr6BlV3HRzf8l7jbYGzo0gZYt/cYN7MEqrHJTcKDyLIf5eY8jFz9q/lxQ1sL6c8iR9odKdpDBvxZWyOHVBHjaoCqgytStUBywfZpYJqdjx7hpOwA8k6PwCQVcGi81XVlYw67vajui4/dWhc16RDIoz4/B8WXjnXhfjmYChtdM1dqiaS9TJ8M6vdjLy8fcn/gxeuLVOJfsc82kw9gYpV3sWT3nDV6Ck8huQ/sJ3PorP12AC5cDpwqcPDXo4f3IAMP76XQMUDyuO35NzG2cg7/4rylOgP2zHqrRfsd4C6w1Ll48/UTRR9+lROHi6Mnche/3VNb9bBM2McH2LDYFaPhh4GRN9xb0dUzLoxuWFiTDWZkH99xgErOB9IRS9WucSx3j4jjy72kgSYnK1QOe/Qw2y0LScxn9H8MbrrzE6lKNXtWrR3rWrGPwQnM428Z5xP1oZ/GFAMoJClJgSqIPQSIQFYt0hKmoZxaxtkQKpCL7npO+0/1aBb27BsP9LMYqJKhZeUu6F1lMBjs59JISdo/SDsUePkdGvOOhnW4Q1p68HcKXl77VibTuNrmr8+BfgYxjtPly32d3ufzu6e0B7ylTZiy86bAK/DdyHqpQVGjiLFAG54XPFncPtZKhgh4xqWXJv4i8gPGAUU3O3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFZdGJuMWNnZEFWOGRyVTBWVCt2ZUo0NkdKcUY1V24zRTVnS1gyalVpZzFL?=
 =?utf-8?B?ZUdTOWFWbzhPc1FVRE1wVkhMYmlOY3ZNeEg3dnJRSE12bFJGUmR2dGFEeVBr?=
 =?utf-8?B?V254aDJiU3paVlE4S2ttckRnLzFxZVZQTzRSMjhsZnBHZW9UYlcrRGdTR29r?=
 =?utf-8?B?Ui82bFNaL1dFY0hqU1pOQk9RODR3Tlpha3M0MlJLeFpHdXY3OUdMblpVRHVE?=
 =?utf-8?B?b2hJSDgyY1FoQXNwSHFyTGFCVnBhZDdqeUduTTkxZHlPS1hyNEtQR3ZrUS83?=
 =?utf-8?B?ajc0aFhMUHBGdlFHRUwyb2pFOW9UNTZyeHJscVMwOHNWOW5sMDlDWWJpSVQ5?=
 =?utf-8?B?aEg3WlVVUHNFa0s4VUJUYndGdEFwdzZGd3NXSHhOQlNObGx5dWNFRWpHVHNu?=
 =?utf-8?B?bUIzTXkyRjcvSDNiVmJvRGtkckRlVmFlMytwWHJabzhKRk1HemZGcEs1c0Zn?=
 =?utf-8?B?ZlI3cUhrY0xTbElLaHVVQ3djN3M4SkV2bjdRSEt6alJpMVBHcFNHRGJsNWJk?=
 =?utf-8?B?WEExWlpBdVk4aVIwakJBS3dPZjFkQkp0TlVNMzBxNnR6Vk5wOFdLWkJYRGlI?=
 =?utf-8?B?by9pSmZWVktKUUd1MXZ1MmtTRUFxbk9xdzV0VVVmZ1hlajlVYjdEYnhtc0Zs?=
 =?utf-8?B?Si9jcVQ4bTQyTEdDWlk1eEJvYUdwWTdRRU0xYW5LbnJNMk03U0NwdmhyaHBC?=
 =?utf-8?B?U3g5T2VyWk1YeGQ4cGFnYVQvRUpaWExTMlZsV0l5TjZPbW5vRlhjZGtTVDdS?=
 =?utf-8?B?ckx2c25oRHRqUkxwQXdpUTJwa0dSYWpKTmV0RFd3ZXJOQ0hzakR3RFhGUVpR?=
 =?utf-8?B?ZzFpSGExOGlDOTZBMlpPZnNueFF5MWFIZTg3S1RzVFN5NlFSL3p4MWpKVFFF?=
 =?utf-8?B?b0tXT09IdUlNN1hyL3VQNEpPbnhtZTIvTndrVGpqK3AvZlBXR1FEaFE1ZWJK?=
 =?utf-8?B?L0x3UHAzUmhmcmNKY0hZdlhYV1ZRQnJPclhKY2FEbGpZZnc0N0t6WVFwbVlL?=
 =?utf-8?B?OXViRi9IRlB4bVZuNUhyY0hYMmxQYWt5K01GUzJqVTRMc3k0SGh4T1lnQ1Bm?=
 =?utf-8?B?ZHlkb0pyQ3k3NWF0WVpBejl0bG5FaWNmSDMxaS9sekkzczYrZlVnOSthVUQ2?=
 =?utf-8?B?WjRycGxqMldudkNWbGR0Qjl4VmhRTGFnWkE4WjJlMkZaOHNCM1p1WjdtUTE0?=
 =?utf-8?B?OW9GdDJBRVNQZFQvZFdWNnBsRjZsakhtVWc1bGl0MjRzTnNBUFcwckVway9w?=
 =?utf-8?B?MERHK2Rha0ZpbHBqNUlIWmtnMy9FVVdSRUpPTVdOc2xyWTdtaWdjbldYTDFh?=
 =?utf-8?B?dkpoVFcvYTZSbXljdENVVmswc3p2bGRmR1JoNlFEWHdNYlJHdnVZK3JpVTEv?=
 =?utf-8?B?YnYyZVRqbHY2WEd1bGcyQlkzMnh6cnFIM2dGemhwTGtRWVFscHBLWTJVbmZL?=
 =?utf-8?B?UUxaZUN5dzVwQWtCb29PVzY2L2VDaEF0UzlUK0dQVFNwUzM2em1TZFdIR0E2?=
 =?utf-8?B?dnJIK2JMY1k1RWdpaDlMclRicUQ3NzBMN3ZscXhSa2EzNGFWc1FhU1E1Wmtl?=
 =?utf-8?B?N2prejU4TjZraEM3VWFaM1FUN0dEN0NDS3F1ajQyWGZ1YXNSMVVMdklEQXpo?=
 =?utf-8?B?cnd3eERBVEo5S1ZySXZ5L2RmeXJXSTNzc1c5SVRqQ3ZpclNGbXpkK25Mc3Zk?=
 =?utf-8?B?dTFKNkVkQWRhanBYMUNlS1dzQUVvQzduZ1lJL0RqMkJTc2RzU09wZzVyZUpo?=
 =?utf-8?B?aVhlcHhRWUNKOUlOMWJsQlRpMVVhc3RuVjgwMWlCYTRoQmtJaTVRNDdYYzYx?=
 =?utf-8?B?ekI1TER0b2hEdWdWN25hM0diMk1YOFllU1FZZm05M2NqMEZvSXdqWFdRM2p1?=
 =?utf-8?B?YkxDbCt0cWpuWUlqVDdFeXBNRUc5dkY4a3dPMzVVRkhlQS9uaHNQS3U5UitF?=
 =?utf-8?B?dlQ3eFphaVdBMkRvU3ZEb0R2TmVFV0k0TXhqcW9kOVg0c0JLbzhxRytNd1Z0?=
 =?utf-8?B?T1JmWmlYdXFCRElwblcydVRtVVZJVTR2NjI2TXE5SW1MNldqMVBFb1pqK2tm?=
 =?utf-8?B?NWJLN1BsRytuS1hsL3hVZ0xJS3lHY0Vhb29pREZpVFBKT3lvemVwQnpwaEZj?=
 =?utf-8?B?YmR2ZHB0WWt4MHRwTmFQWXZTbE5VOUFlYjBvZ1R5LzFMWFh5MWt0K3VsRGZI?=
 =?utf-8?B?T3Z2cVRvcnc5cUFZeE5iN3QrVjh4c2JITVZSOTlHYWNHc3lIL1phdEx1eVdO?=
 =?utf-8?B?V2xIY0UwWEdMYzlVOC94aHhxaVVUWkdPVVhsQ0VES0d1NmkxYVFiZXNZejZ6?=
 =?utf-8?B?SUlYeHpFZEhmZy90c25DK01QNitDRm8zWHlvaXBFMXZrM2Z4NHEzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071d1db7-5edd-4c73-b557-08df43c7b4bc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:55:12.2280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PZ9wFpz5UY0tHK4269aU4bLfJG8e6aTTD5/PWzHfiaZQxwL3EtaZk8UR01YblpRAG6nG7dXnTHj99fMuvmItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shivam,

Thanks for the v2. Hugo posted v2 of two series on Nov 13 that do the
same thing, so it would be good to work together on one of them:

- "Leave self-refresh before an ABM level update" [1] takes the panel
  out of PSR or Panel Replay around the DC update that carries the new
  level.
- "Commit panel_power_savings writes from the kernel" [2]. Its 2/5 is
  the same atomic check change as in this patch and David's 2/2 [3],
  and its 4/5 commits the write from the store.

The part this patch is missing is [1]. Once ABM changes no longer force
a modeset, the level goes out as a fast update while the panel may
still be in self-refresh. On DCN 2.1 that hangs DMUB: Hugo hit it on
Cezanne, and we've seen it on Renoir. On Strix (DCN 3.5), with Hugo's
v1 series but without [1], a write on an idle desktop left PSR stuck
and the ABM ramp stalled until some unrelated commit. The IGT run
doesn't catch this, since the panel has to already be in self-refresh
when the level changes.

Hugo's 4/5 also skips the commit when the level doesn't change (as
Harry asked), sets allow_modeset to false so a write never turns into
a full modeset, and takes a runtime PM reference.

Hamza, agreed on running this through promotion first. We're putting
Hugo's two series through this week's promotion testing in place of
this patch, since they include [1].

Could you test Hugo's two v2 series on your Rembrandt and review them?
That's DCN 3.1.2, where PSR is on by default, so it covers a case
neither Hugo (DCN 2.1) nor we (DCN 3.5) have. It would help to:

- let psr_state reach 6 before each write, then check that it leaves
  and comes back
- rerun amd_abm, which Hugo hasn't done on v2

Hugo, please Cc Shivam on v3.

[1] https://lore.kernel.org/r/20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es
[2] https://lore.kernel.org/r/20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es
[3] https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/

Thanks,
Chenyu
