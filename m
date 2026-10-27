Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0E606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1uuYwXWQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E28F10F845;
	Tue, 27 Oct 2026 21:39:45 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A2410E49B;
 Tue, 27 Oct 2026 21:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGM/JU8cFoFkTWFK+gCcvlzKYnGKfNNrx6hzaKwIfoZKmDvEsV1UQzTEiqE3Kzgh6Ps9DKz8/5qRMzd1zzMhiVlxBJZouiL+0B4lKN9F9bEkQ1GGUiZuvR/LfHcz5H4UDfE0wG1d0UgDHxNRdUDF7I6sFVnpNkF6Z4M9bgbIrNv3P5qXTCouV/WW97yYgScgOS4l9IIi8kxnKJ5b8M6naTQs1yK6Wnxx5/Lyc4UcOeXwGWImFp12F28u6DPD9UrssXXSJHPN3GSGbdTfs92XnEBSrEVeO8GN9ltKddcqskqmMwYViw5bYX6i7s+HBZ13tDnZSSGIF6NV+N1RAe868g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by0WSEq1pKv4CYxHbkdCM7Yq9Uxx1VgyJqzrAXN1xUQ=;
 b=eZvGnw3QgXXMSEDqw8v+HkdOXpFDm4E8SCiZdAO6TYNbhFzrT5yBkErO/JiVyACT8yDhB1YHuwvausycEufEKzYu845oJnV1wwdB2JbLiwFvyTNT/CTZeWCjHG3cwVl99pexUe9qbsDYnbne8yNgokkTxRqWQXtrx2r8Sewc89UM76YI8vWSuM649nSfhzx4zz2flu4f/IoV77bRkg4USW5vMEE3sj5nq3/tdonYLyRSLeu2UNxbgk8dob79KH8ESE8im3OQbx4Ucg/cPiwauTaHQY0/sefDO+dyAji4PKc0gf7AHTPhPebiGvLRJ09IfsvQP4e/fjpjytJaI2TaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by0WSEq1pKv4CYxHbkdCM7Yq9Uxx1VgyJqzrAXN1xUQ=;
 b=1uuYwXWQI4ej2eafti4JBxJfSCuLwuL9mZq6pLqFiRI/dcAfkzO9JlJbedF/sb3vM3PyAb8Rk1DyXuXeWYuCBHjVGPibMLkF4S3cmp0dSKQm5SEWkLF7EWxGKdmOkGX5zIYOJs9e11fF0VfntYeZffdSiI2lctRvCZ0bQFZ22pw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:39:33 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:39:33 +0000
Message-ID: <24f05c8b-96ab-454b-abf4-ae28ccecb809@amd.com>
Date: Tue, 27 Oct 2026 16:39:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't warn about vendor infoframe for
 non-infoframe sinks
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Wentao Liang <vulab@iscas.ac.cn>, Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261027185414.162183-1-pmenzel@molgen.mpg.de>
 <ba77a6b8-f79c-496f-ad45-9314ac8f8a46@amd.com>
 <75709eb7-6ff8-44ce-9f0c-84ff47c6ba22@molgen.mpg.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <75709eb7-6ff8-44ce-9f0c-84ff47c6ba22@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: d633315a-3eba-4086-6c4b-08df3472c9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|6133799003|22082099003|261026121527099003|261021123027099003|10067099003|56012099006|5023799004|4143699003|11063799006|261009223027099003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: vWnXLH994hm5gHBvI0RzR5NoyqjI62KS7cfSkg7Ctv3shauP0DFb4TnZripFScSPZtEseP19FzgCaQkO8Ma98mcwAYLxJIfYFj7mDVEHsJzGIpoz6CWSeuDfNalxOIcSXEkXyqNETS3ZdLQ+GcNQaeyyy9BlPq824dh5MQeMZAJgzTgXmBMJzcCaoxrSd82EDHmVxtN0MFLNGJnNgFFiZTqYL9m+CsjiuBT0yKrcGChTr7xCphugb14zkGdy5UrBx5PUjRXD/PHYuqGrE3Inq8F8R4K8UJZAwCTH25ycvG9LE5QpwjdHcYjWrTS+x0uWQf2uSuTrkY6/2S5I4j7yliZ7bZks9seRxaYvM+66Y+uKtrUmonbzltK0rLGr0FUXWbeqnN7mHUcXIIvKKB104kqSQOvyo1skYtuF7StfEz3lByJDXzUbxLid27oiRTLjFBzkSvH4bPF9oH51zUtCbKvxKg1z19THdVpvaUiMUMsksrPzIUiagkqobwZJpVQx+kfS6clyG0pyoYDIPz0neJEEBvy3eRqBNThnF/fw8XfTaWMu00GmPFBTd+cnhNIP8GycRq5fHb0wiJACRwdOwZ6ij0hDEznLznmoFqUkNBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(6133799003)(22082099003)(261026121527099003)(261021123027099003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkJUeHc3VEJRelc5Wmw4cXpib2J4QkJmT04rdGd3SS9aZURNUnJGSnFpemhz?=
 =?utf-8?B?OU5IQ1FKQzBRK2J2eGYxYUhiZEZtMldIc25QSHFHYlRTV2xDRmkvTFBhLzhm?=
 =?utf-8?B?U0xTc1VDc3JHOHB5eUNndWYrR1cxUi8wSnRBYVVZYk1yVmZsVVZmYmpRVFlJ?=
 =?utf-8?B?SFJHYkhEZmh2QUU4Uy9jZE5xcE1uNDI5MStudGs1SHRLZmpSd0x4dFZ1UGVY?=
 =?utf-8?B?MTJuUFRUVEFteHhnRm95VGdWRnMzQTFGRnhsYmFiTUJ1bWJ1OUlqODR4QndY?=
 =?utf-8?B?MElqYUFzQVZiRi9pVFFiVUtPeWVpYlNHQzZMR1lxWjZRMmxZT01ISUtoOFpo?=
 =?utf-8?B?MklpRUxKRjhIb0JjRCsrblZUQUxBVGl1MitFbkpsS0pXekR2Q2RBUCs0R0du?=
 =?utf-8?B?V2hOMUJpK2FLcWk5Y3ZuK3dSMFZhdUQzZjk1ZkdtUnorZ0plME92VFVRckY3?=
 =?utf-8?B?KzdVVi9nbVZ5ZUl6ODVVWWMvZlpVY01ObTIxUURzQk5kM2ZyQm9lZXB2NVRq?=
 =?utf-8?B?ZnowVjdvN2VGUkJWVDZmamZMc1hITmpJMEhIbWl2VFp1MHJnWWhVSERiaWdo?=
 =?utf-8?B?M1F1cm90RjJRdWo2S0l3M1BuWlh6bG1HeDhRaWV3TVZUVjR3amQxTDBMd083?=
 =?utf-8?B?azVLZ25xWUY5RFNQSnJycC9hY294ek9HcW9WcXMvUnVwUEw2ZThjSTlBTkx1?=
 =?utf-8?B?SUpCYkMxR09HL3FXM2IwR3dEM29wSTRIOGljUXZvNnN5OHgySnRjOFphNVZZ?=
 =?utf-8?B?dGVLTzJpS0xBMW5NSXp0UjRnVlZ0S0NvUEt6WmlkUHhKMElIekdNcHVCY2c5?=
 =?utf-8?B?cWZwQktZZjk5enBRanZFbC81WWJWdS8ycHdTWlhqdU4zQmZXWUZMK2tQSXAx?=
 =?utf-8?B?Y0E2N0VTajlZMUQza2JwQmhxK245Q3EyNGxOazBFUmRKTklLUHhsQ3lmeldw?=
 =?utf-8?B?SUlQdk5ZZmFiYURpUXF1M1VCVnQ4dmFnSGN4R2xVNzB5YWphWk1IdzEzRCsv?=
 =?utf-8?B?SDFuaTE4WDdma09uQ0ZoQlhPRGtnNG9tbXhhQUdwZFZTUUVaYzV3eHl2Nnpt?=
 =?utf-8?B?K1BBUjkrZzJ2TGFETlJMU2JNeXhCd2xPbFoyY3lheUJMcjA0dTJGZjVLSDRD?=
 =?utf-8?B?NFU3Y3JUY2xNWlhnWExhekNPcm5GNkxmYXMwVUw1d3FwNFFzbFFtV1hzdGJO?=
 =?utf-8?B?enVkSzdXZmplV1RsWGlEUHVJSWdZOVZ5NHpsckFSVGVkczFnK3lMK1ZwYXNm?=
 =?utf-8?B?YkVibTdUN0hRT3pFM0pRQ1RMSXNzV3VJby9xZENWRG5nUER6NFNXTVFmalNy?=
 =?utf-8?B?NHc2WHphZDU0QlNwVVIxUnEvRDJ5Z0hzTFdHVDZQTkhvaGI5UEdFRU5Ya1Yw?=
 =?utf-8?B?Wjl5MkgrY29Fc2M5V08ranlGSjg0cXNZRmhEQ2FYNWVmM3pycTloNkczMUZR?=
 =?utf-8?B?ZFNwc0c4dG5NRU5BV3UzcHZGR0JCbW5mcTZMVFNHZ1RQM3FjUVAvOVRnV1lu?=
 =?utf-8?B?S2ZvMlhMRjRMU2xhQlVCYmZRZ0VrOGkvRnlxSG9qWXN0eHpNSitVcTUvRE5x?=
 =?utf-8?B?L0k2SFRuLzhnOTFuaHFjRnZMMlRyRWNqNUErcFl1Uk1SaHR3eTNmc1BCdDlM?=
 =?utf-8?B?QmJ1djlwc21CKzQ3ZmROVE12QWwyZWJqeXNaM3g0R2E5U3IrMmp5UDI5akFV?=
 =?utf-8?B?RXE5Nkx3TnpwcytmcXNwMkZTdGR2R1dZeWV5UDNlNXZzaEZ0N0o1L3RzRlpa?=
 =?utf-8?B?U1JSaFppZDgwTkZkNmYwQ1RESDN6cHRvcnpZU2JnUEZTWVBRWkV2UDZ2N0Vk?=
 =?utf-8?B?RGl0dkFlRTZWVkR5OGJ5b3BxTnEwclQ1VVF4WnNyR3oyNU51ZjArNGY1ekRS?=
 =?utf-8?B?QUYyZkxIbm9hb1hSY2VUOFpyRHl4THhPNnkwM0ZLZ0ZLVEh5SUZwdVJEdUJG?=
 =?utf-8?B?OUlmRzRDYm1QcVVLVWZYQzhtSTJ2Z3ZUTmNYWE8wL2Exc1pWanB3WXpWV1NC?=
 =?utf-8?B?c3RjOHdnL0grNkRoamQxejF1M2o2czNpSk1RT2h5MUpuS3cyTGhkN3ExMVBC?=
 =?utf-8?B?RjRBVk1XQy90Qlo3TFIyMWhGUVd1ZlV3YzduYkNyQko2Y3NDb2F4TGtSbVhj?=
 =?utf-8?B?YlpXUU9scXV3ZzBuYVRwZWJYbkx3dmhla0JDTTJrVTlrWFY5ZWhBSGFmUlVK?=
 =?utf-8?B?ekUzR213bS9TVy9tems3WUtlT1FYL1hqN3M3QkR0OXhNZ0hwbk83VUZZdkJI?=
 =?utf-8?B?cGZ0Y0hBSmh2NTVRMk5lQ3ErVW5KOVdPdndNeXJYY3ZtdjZXU2xHSVkvamUw?=
 =?utf-8?B?dVE3ODE3R3B2MVd5Njd4ak1iQTQyeDJ2c2QyWENKZzJ3YU54OUlVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d633315a-3eba-4086-6c4b-08df3472c9d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:39:32.9443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkB/4eXE+EvP2+hx4Ud0psQOcOqT2oISATcmwBu0DTKGZ1tP3ywzQkjD/SI39+EMmxg3L8OlapRU+bR8xKhURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 16:32, Paul Menzel wrote:
> Dear Mario,
> 
> 
> Thank you for you reply.
> 
> Am 27.10.26 um 21:48 schrieb Mario Limonciello:
>>
>>
>> On 10/27/26 13:54, Paul Menzel wrote:
>>> With an EIZO EV2781 connected over HDMI to an AMD Ryzen 3 2200G (Raven)
>>> on an MSI B350M MORTAR (MS-7A37), Linux logs at every boot since v6.16:
>>>
>>>      amdgpu 0000:30:00.0: [drm] Failed to setup vendor infoframe on 
>>> connector HDMI-A-1: -22
>>>
>>> Commit 6027cbee1900 ("drm/amd/display: Add error check for avi and
>>> vendor infoframe setup function") started to log the return value of
>>> drm_hdmi_vendor_infoframe_from_display_mode(). With `frame` and `mode`
>>> being non-NULL, the helper only fails with -EINVAL, if the sink does
>>> not support HDMI infoframes, that means, if
>>> `connector->display_info.has_hdmi_infoframe` is false, and its
>>> kernel-doc says, that this error can be safely ignored.
>>> drm_parse_hdmi_vsdb_video() only sets `has_hdmi_infoframe`, if the HDMI
>>> VSDB has HDMI_Video_present set, and drm_parse_hdmi_forum_scds() sets
>>> it for sinks with an HF-SCDB. So an HDMI sink, whose VSDB lacks
>>> HDMI_Video_present, triggers the warning, although nothing failed.
>>>
>>> The EIZO EV2781 is such a sink. Its HDMI VSDB has a payload of only
>>> seven bytes (source physical address, Supports_AI, and a maximum TMDS
>>> clock of 250 MHz), so the byte with HDMI_Video_present is absent, and
>>> the EDID has no HF-SCDB:
>>>
>>>      67 03 0c 00 10 00 80 32
>>>
>>> Only warn, if the sink supports HDMI infoframes. The infoframe setup
>>> itself is unchanged.
>>>
>>> Fixes: 6027cbee1900 ("drm/amd/display: Add error check for avi and 
>>> vendor infoframe setup function")
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5025
>>> ---
>>>
>>> Notes:
>>>
>>> claude-opus-5-5 (Claude Code) assisted in analysis, code change and
>>> commit message.
>>>
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> […]
> 
>> The actual change looks reasonable to me.  But a few things about your 
>> commit message you'll need to change.
>>
>> 1) You are missing a S-o-b [1]
> 
> Sorry, overlooked.
> 
>> 2) Disclosing LLM should currently be done by
>> "Assisted-by: LLM" [2]
> 
> Since commit 1e035297ffdadf (docs: remove Assisted-by references) it 
> seems to be deprecated:
> 
> $ scripts/checkpatch.pl 0001-drm-amd-display-Don-t-warn-about-vendor- 
> infoframe-fo.patch
> […]
> WARNING: Non-standard signature: Assisted-by:
> #35:
> Assisted-by: LLM
> 
> ERROR: Unrecognized email address: 'LLM'
> #35:
> Assisted-by: LLM
> 
> I wanted to send v3 with the tag added, but would refrain from it now, 
> if that’s alright with you.
> 
> 
Yeah; just send an updated version with your own SoB then.
