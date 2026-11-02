Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D3606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SA76er7r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 220CA10F112;
	Mon,  2 Nov 2026 18:10:33 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D98810E12B;
 Mon,  2 Nov 2026 18:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny6RGzAI2aHZIXi7o233nVrxp946+Wt0w0QnH3pU0eZV/SGsiWx6o3mtNj3qRntcUwSG3K+Ws2JX3ipPfGnGkbh90WXU5ZbLfc6td/yUScaTVpxpawWKY4d4z3zO79xJDcz0/zOjPzi/YGpe6Jm58W9s+f4GsFRYdy+xjCZfQkD1vlVgLVxrmjf+vKvPaICjihKy/4y4xsSJlRdp+yCPnZLUtC/Jpa4IyDqXIZJpmVBzYzAOq5ehZPJp41cnZGUpqlaVBdMAQH6a/dquLj/r8ukCXb3BRqQ2Wc5lR4t0thgnWUz8DxZ+ZVcAolxY0gGyimym9B41DYQN3D9UHcdDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucvMdtjiLVoABEvKRo2xr8tEAutU4s6rE8d+lZNMMG0=;
 b=tYGhntUC8AENgNvFwt2n65TKKhjEm83ATWDexg1q/eIhUTYmRmTe9RjaHyZ0BNcNp0fuBZ1cO2omcT6ornBvkmjve99di9OiuGnXpX9spq9IwhZsQwSx36Z8LqHsfADG7zlUyZiYFjs3LZh5LQN99umegfk7sHSPgnrzq4cbrPy5EHkgfYC8uqiy6hUnZZZ+Evo2R0OSxnx5XPEBhp2+g3i0MjZzQeC2hY0PV4MXuqay1aNQ6PRduGqxLPmyu++BAeoIYgwXg0Z7aoqIlYiiSjIfu499J97lC2WxH0lib6l9ZZNEqSVKbmLnUE1rifGVuK+O/Blj+2siZI+t/Co4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucvMdtjiLVoABEvKRo2xr8tEAutU4s6rE8d+lZNMMG0=;
 b=SA76er7rLbbc9zPs62cn3ooeYU3VOqOfIhIQe7nzPRoe2jbfUt4V+A6O8SwqZ8pgIm/Esrs/Q+/15am9Kbecgpw0T65hY/vCVIfNP0sYUsUOS4ILYfn2Ln1L5jh8qZGlKFoRm0mo2WE59s0HCwgpLEZ9T2ZHEpIkhIayvmWZfLQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:10:23 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:10:22 +0000
Message-ID: <0cf3e98c-65af-4bea-b59d-e760b44a02d5@amd.com>
Date: Mon, 2 Nov 2026 12:10:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Point the DP/eDP connector ddc link at
 the AUX i2c adapter
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Richard Hughes <richard@hughsie.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, simonit.orig@gmail.com
References: <20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com>
 <CADnq5_NomTyHwfX1AoHJwOB5Z9pC+5Tqq35kRdszCAzmUqkpuQ@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NomTyHwfX1AoHJwOB5Z9pC+5Tqq35kRdszCAzmUqkpuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::29) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: ad15e2cc-0232-43ff-a3b9-08df390c8f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|4143699003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Ac7DirG34U7B8qp/4yePETGOB7Vdq8QVuAWkRW+1fmmTzAQ/3Fx0DD7gNGwAX1aLx9yW9o5ffXhG8qOotyIPVULymz9IgPEDbdlPg8BZC42RnHDjCW+vfED+TMHl9LxqfA0N6+x2ThjcvZGwUhPheGdlKvPag+JRtn+AWo9RBAEQC1HVRjZki6Waloj+7B4aCTBSlIIiuIZ9rA3lKdvO6GeB2b/t5rAe/1aqrm09kYUf7mGrt0JBZlW1OidZSf8EmymvkncdoGDcAbtpQtxewyiEmYu9QRB4aEwun6bd+difL2ZoouuWjjYdGLqCE0+G8Vcl+ezAA3oQ4ZtvEVQdDFw/SKYpii2S9dPwYRKzMWfAlJicgxXobN3h0wE3L41Sji+zzcjQxvSjQG7xek/wRMXjBnOcLgG54gKBRlqJqie76dQdBhXKj0QpVrIEMIFN6Hxj+e74AYpqIsf4tV5+EXPbTZ6DEDQJsDfmGJKsKq1/aTSzPJ841cSbog/5P1pnjl1RhAqDnTepBGBeiN+RmWqzT3MMsybCPDt0icTmOS4LDh4YjTbWULRcW5QFEyom+ee2ExiC7bzlwhMnRWxg6fbcOFFYJ9FcYcGl5PXd1X5sx5Q4WnVVhm9ezcmxcFW0XHraj84Ay+U5SxzN0/p+i+nge1zUkAxtPXD6Mk3c34A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHR0R2JSSndsTUhlYkxRcHJ2bEVhUDFUV2ZLSFBadThaakhKWlFPNmYvVVlJ?=
 =?utf-8?B?Mm1kUWZoSWpBUm1TQ0RWQXVEcTJQZVQ5ZDdjN0VZSDFrVnlNd3FZbWJ1a2hE?=
 =?utf-8?B?aDlzL2ZEWWYvOWdWckxTTGlDWUpDQUhNWHZBNFEzV3BaejgzOXdXU2UxOEI5?=
 =?utf-8?B?S3c1TlE3aHdOVS8vTllxd3huU0RGZ2IyUWV6WWtCelVYUllyNS9FZVpxUGJ5?=
 =?utf-8?B?aGgvQUNabTBiQXNSbExvb05mdUUzY2ZQWjBHQmNVL2pIcEZIcThNNmdvdjF3?=
 =?utf-8?B?aytGK2VpaGxRdndzUW9XMk5DL1B5WE1EaklzS1RocjArSzRwTWNKMUxmQWEv?=
 =?utf-8?B?WExHSzZWaytoU2hOZ1JlSmFRSDkreUZCOVJEZU5WN0h2Y1Y1cmNPeHNaa2RN?=
 =?utf-8?B?SDdLaDRpbHY4MEhWNXJZYzlOcUNFVkRMRFNsUmZjUE5EanlvNUI2RFEzVjE1?=
 =?utf-8?B?RXNSSUJnZmU1UGliU3ZpZGJxRHZ0TWVxNVpIRVlIem5WbDJkUTNxV2h6OGZU?=
 =?utf-8?B?ZklBbG9QQnJMbExsR0VBVEVyVnJxVzkzYjFJd0NoVnRkNVZvSUJOa3p3UWlJ?=
 =?utf-8?B?QlFhd2ZXZUpZajZsTTg3VDlDY0JEUjdWOGRoVXRQTUpGZ2JuRmsycjBtclhH?=
 =?utf-8?B?UWhOWm5GZWVJQWlRVnBCWFlGLzZHOHR2VHJ1TkNBS3hQbk9DcnFHcnloNDlx?=
 =?utf-8?B?djZTd3Nick1pNUIxekpOaGplS1NIdTU3QXpUcmpUOHcrSjhtVWtha1dvTGhj?=
 =?utf-8?B?NUdSTytJVDA2SENhRzFRRHlJSFRBR3VqbzZycW1MQVpaL25GTUNEbUxCZnZz?=
 =?utf-8?B?TmRzWFdhMG9zaXNRdWpUdUFJU3dPUW4yUjN1UnVDVnpKV3JubHYzNmZxTm1k?=
 =?utf-8?B?VCsxbDhIUWthM3M4RjJDdDUzYkZKYmFWR2V2aXozVDB2WnZqM0E2U1IrL1Y0?=
 =?utf-8?B?RmJGdng2V2xEK2x5bTdITXhZOVUwbVpSWUNUYkozZUpxcGRXN2ZlTjUzcm04?=
 =?utf-8?B?cWEyaG5QbWE4YmdrZUVQVVNkUHhDRnpzYzhjRmVvSy92aGRhaGVsTU5Qcnhw?=
 =?utf-8?B?N3lZSHhhREVuKzloSlZCc3hRYmQySFpUMHk0ZE15aTIxQ0pPZXdlVFVWN2xn?=
 =?utf-8?B?VG1nczYwNjlHSlI1MThUTVdRelF0cHpEWStyRkxqUExLNlhSNnNaZmdpN0d4?=
 =?utf-8?B?dGtxcGtJNlJBVU02Yi9mTGlLOUpZU1NJNHNZWVZ3WnBTUWRObFo2MEJlR1kr?=
 =?utf-8?B?TG5nMU9BMU5DRGZFVFBSWU1zTHFBalR5STJIQ0lqbVMrV01VQmtvODJLUFA5?=
 =?utf-8?B?Q0hiSXh5UkFYYnNna1ZJcnlic1lrM1NrYUc2S21nSUM2TkVsLy9FZWU3UFNk?=
 =?utf-8?B?b2FZUkRhR09lSkc5WVBxRnB3RzRDRmRDVFo4eHo5eFN1U1BiaDZnMW00NHdH?=
 =?utf-8?B?Zjg4S0dRNWQyanpSNUkxQ09QMVovaWNiU3pZVnVkbzI4VjlFZVY5UmFzczQ5?=
 =?utf-8?B?UWR3WmEvcWZKWDY5RWNvUWM5WXRTaC9JQkNRZG1KTEp0cm9udmlSMkZYUGJI?=
 =?utf-8?B?STNYSTRORDR5QkRVN2t4WVV5bUkvc1Vqay90WkNqZXlCYWJadXhFR3J5OCtX?=
 =?utf-8?B?T29pRm1mOG1nZHhXR2lTbndsanc5ZCtta1hLSFNzTWVwYkRoUnI0enc0S3RK?=
 =?utf-8?B?MTdZU2JtVkUvU3M2N2htRDk4cDdZbmJCS3Z0dFJLQUQ4SlVLcStPVVBKN3Bx?=
 =?utf-8?B?V2hOOXpPTG56c3QrbmZjSk9zOENKZE8vSnVZOWVqMlliUzdMWU45UlMyVWJz?=
 =?utf-8?B?blROZFlNREk2SEdvYnBGQVNCMG94SHVBQVJVTkpCMkx4RjN6a1hRN0VpcGJH?=
 =?utf-8?B?WVpNTFNOMUtCYThqRld4SUVUOU1LQnVFSmtEbXJjS0o4MHlDWDBGQy9KOEY5?=
 =?utf-8?B?L0ExWHZwNGJkckVLZEVmZFlDaTFneTBIU2RLT1FqbFVZSHp0SHlUY3AxdjVr?=
 =?utf-8?B?RklNSUpqZ2ZYSmhrcC9oZ3FXMW5RMlNPWkJ0RXpwb0NnQTllcGFaRHIxMzRK?=
 =?utf-8?B?UVFOZTVGWGh5b01BeVB5MG00Slc1eUllUi92Yjlhc1hGWStoZFNlY1FWQ3Q2?=
 =?utf-8?B?RVFJcW5telFiM1EwanFvZWJPUjNzY3ZMaGJVWTNCN2d6NDM0YzhQZ0g1aUph?=
 =?utf-8?B?UE1Nc09aZFBBTEFiL0NJMXZWUlFvRUhxRDRTZTBMZXdaSzlJVmk0R2tNbmdO?=
 =?utf-8?B?aTRFMENUSmpCekY3T0hqMHk3ZVpNek5YY3NZaHpQVWxLNVZkTnA0YmRuL1Jz?=
 =?utf-8?B?aE9Kb2ZRa1dlUFBzVUNLYWhkTFJGR0VpYlc4VG1ZekFxdnpxTGdUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad15e2cc-0232-43ff-a3b9-08df390c8f78
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:10:22.1449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kp36XiaCmeQ+HbO9XCl8IQGDrmkwNC0FRWhH5oXdfNeyk08h5z85yuzGAz0l8ICE1t09hbCVqbFm0asLHKl5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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



On 11/2/26 12:05, Alex Deucher wrote:
> Would this potentially break systems with passive DP to DVI or HDMI
> adapters?  I think ideally it would be better to expose a single i2c
> bus per connector and then use either aux or i2c depending on what is
> connected.  I think there is a way to determine the sink type
> connected.
> 
> Alex

Yeah; I think you're right this could break passive.  Let me see if we 
can just change it on the fly in amdgpu_dm_i2c_xfer().
