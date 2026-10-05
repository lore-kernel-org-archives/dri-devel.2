Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C218DCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D118A10E2DA;
	Mon,  5 Oct 2026 21:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZS11+p62";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43E410E2DA
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 21:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAwcHkUYRbSbbGGORqKgl+bAhMnBU6a3ZEiBgVfphoOgRNVhqxEJpQbIRQRWfM49YpIpKt6xp35eFQ/13xJliwrY/+wW8AUz8/Cj/wfPUDSnbNB0rgIxO3xIpKpQj/5oLX1/+A0gs++EqioWdD5+c1MxULqAORtDymo4w2svbdU90GULCvgeZF7SDnrA9vNUuZ5JvSX2HHdz/rJQoKDajIaYBpAfd9ONDcQwBWz+7ZHUt80BBJO/WSMiGpVQOgib6OrlcIyFt8T/R449zOwwFPqrXJCiJjh/10fcM85u1WEM+n9pAMGenYjclgebX/457eKceS3VVvK/YbokYt1X7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVB4OiX57lwq/lePepP55usQgGFUNLzfTjjC+90YpM4=;
 b=soyD+kz2mHPRhBimjX651xAC73VxxS31e8x/t28vmAgkUro1HQlKn4xCKB5Iwyg/U1q0a3uMhJDYNS9iPKXvW0Q2aghBQiI6rD175CRskQ0Iod/I131Ldif49BuXjzi9EJiO4w5xoFGQOPUIl7MRXYSHJG1XyiHTR4etnzOPlMQ/g6jw6disIKem9XqS0SNOWyk/zfBdS66TaIPHC0XMuWJhDaDrKKIrxTxc3vWz/C/GVtuZMZ9zmEhvTv4c3P2pkSVgqAVRdGm8dYotHoeCo8Xfl0B1DJcpeuO5SXJA+Zq+G1ZfO4H6qjcgneLkKJbmzzfgZbAin9ICrlguYQ3UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVB4OiX57lwq/lePepP55usQgGFUNLzfTjjC+90YpM4=;
 b=ZS11+p62MA3Mg5O2RljB8V01LzeXQPykTdryA296A1Sun8HtYF9+zbRcZqH/QtMYFdN8KFBAWE2LdkIkJrQvOX9RmBxeA3VBKvekWhKhJGXG5XLtE1jkvsoXT10FcWVX/+u0UXxHfDpWY3x3vCVn/+c7cfAyY6GqejpyRnbLC68=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 21:49:08 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.21.0451.022; Mon, 5 Oct 2026
 21:49:08 +0000
Message-ID: <195a273c-53d0-4db3-bc7d-0150bd5db892@amd.com>
Date: Mon, 5 Oct 2026 14:49:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 16/20] accel/amdxdna: Implement AIE4 suspend and resume
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-17-yidong.zhang@amd.com>
 <20260930040712.A27381F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <20260930040712.A27381F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cbbf70-7695-4332-ffc8-08df232a7bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|4143699003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: k/cJktk/ZH3WgK/oEuhG1b6zR2g1X8qBwXh6Wt9ENn7T5qhoCXH+SJrZM2SYlL/n5bml1IH1tKoEiJWKg9wshMugVCoK60Dc+WU7yCa3LOVDULZOv/4vdgaH/GFL2CV6oiE+EGIJJ+CIHLIydSrprEP82xX0H+CHiQJhogmHf4RrGEAfKOvp2j2apy0ZTYWHmBS8498VKYsw0vuMoWkDnYfRLz/BVM8UTYs+tYB1wNaMMQQsz+q9hb3tJ32eKqH24LkAz+S9zRUJobKs2ixA3t+zuEpOXqfLeMVBS4qe+q29/n70gqMOBuOWXOEMxFF98M/rZw3vgoXphGqVCym0LwFstaZqEOLjUR6si5zIPnC3mde2EGoeRUD9g8zl57TUsquJhkneBhpgL/wUXKyjGxLVYr/rotnfkE9jxENMq64LIvMmyFL+bFYf6hZ3FQt+uHGB2TjxOR7IqDUO0H8B/1/P5rdoDrjyISiuWSlDNxN8BF17D88QLk1+olMQ0WZo3Erch5D8wKWyQTPSt39K58TwvV8MQOLVEmCp5dIo3eR/foltrXhY9/XQLYE5Tbalda/INEy6RXLn5hJlnYw/tCFZKe9PlacL/K5hk9t69+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWEyZUdmMTMzd3UybHdmYndGcnhwQXp1Y1JpVDJ5cGlEVXVVTElJOFpHbTVj?=
 =?utf-8?B?NmFVZ1dyWTN1V0N2MHB6VlpRQWxYS3ZBVXZheE9GMzlIU1lxSFJxQXlmT0ts?=
 =?utf-8?B?cHJhRi9IZTFkVmdIMDhWaUk4anRvbzV1Unl2MTM3QjJFREtiWWszaldHTU9W?=
 =?utf-8?B?bXBLSDN3TEtobU13R05UNkdFVGtwWWx1QTNWMGNnck1hMWNKdm9jTU4rYjZW?=
 =?utf-8?B?d2lQM2taV0c0dHJoUERGTGU2MEQ2Nk5hNjFWL2tMT0VoekxqeTBUOVZTU3l0?=
 =?utf-8?B?cVBWTkk0Y3dRM25qajlsSlVSQVFORUU1MEpYcVhMN2Z1azZINzZjVVJBcXZn?=
 =?utf-8?B?RS9VZkRzU2tiMTNXVThEdDAxNnQ1RCtJVXFuWHk5MDlITkFVTExJQ0REajBP?=
 =?utf-8?B?c2NKWUFRZmZ4RVFnalFQbUFRcTlTb1FRZGViZGpXM2hFQ0pPZDNrdFlNMkl0?=
 =?utf-8?B?UStFTnJhYnE5c3Y3VE41WmZ0OUVRTmlGY1BGYkttNEdhTnJraUVmSjFsQkNy?=
 =?utf-8?B?SWlML1p3MVVtcHY3OWVPNjFBbHYvN0ZyVVV1bGRUTzlqUHgxM1dKTzkxU3pZ?=
 =?utf-8?B?bW1kRkVZaDBDck5GUFBCMVV4NCsyVUtoeHJuc3FKYWVhL1RBZk9YWWp5THQ4?=
 =?utf-8?B?NmJubk1ITis0V3EzK1UrRC9iUU5WVzQ2QjVWRDlUUlRwYUxWNnNTQXFWVXlT?=
 =?utf-8?B?LzdrcHE0OGovRk9XNXkrczREQjNDYUZhWUlBNDNuKzg5YzlLMlpJZDZZaU5o?=
 =?utf-8?B?RnppWVAwaEVvcUtJdk9qOVUyWGtBcFJUTjdEVmxYWjhFU2pkaXN6Y0xGMDFn?=
 =?utf-8?B?K1hRRGlHa09Jc2FEa0xha1puODlsNnJJZ0k2T3VWaGNKQUJUVGFCc2d1ZTJx?=
 =?utf-8?B?RnF2Z1pxRjNCSklGQTNsQmNCN1dvSGJVdWkxemhzUDBWRDlnRktKMzFqRXBk?=
 =?utf-8?B?L1ZyZzlVcTNqeGZ2ZzJYQjhoZFRuTkt6cUtIK0lQNHhrWEJOSDdoYk1lb0wr?=
 =?utf-8?B?MUI0ZzVlZGpKTWxoRmtHYVoyY0UvRGp0eGUrNXdFdXVNSHBYVkhUcHBWZDQr?=
 =?utf-8?B?bjRpRHV3TStScjc1RDVhZ0VRWUkvZWhEWU1ZNWVBRTFrMkl1K3lnL3NxRjhh?=
 =?utf-8?B?a3IzZjl5T3R1UWtqaXU3OFZZZmUrTjVIVnVSQ1J3VVlSbG1ndktGSnQwVUFy?=
 =?utf-8?B?M0ZmeXV0dEhzbmN1bTZZS25obDhCbVZndkxwenZPRFg4MExGVmRYWFJNVjhv?=
 =?utf-8?B?QklvdVZyVi9WZFVYTWFvTmozRFNZTWk4eW1yUE5nc2N6STdHM0tvczk2T2dp?=
 =?utf-8?B?QzVKcDNpM0VpSWNkRkhubHFNalVWcXlGcExYOWhtZ3FKMW9LbnpDRDQrNXBZ?=
 =?utf-8?B?MXdNNldrZld5cCtsU1h1bXZQVzVLWVJBTCtUMzBZQmNRYk84M3RyUm5WMnlG?=
 =?utf-8?B?WmV4b2lBVDNoVHhYS0l4ODl3TCtudEpDMnBKbU5IODFpRDJ4U0tvR005SlJr?=
 =?utf-8?B?aStTdDlZOVhHZmR6andIdk80anZkSjdPMVdLTEYwQXVGSEk1VitmYkFuRm52?=
 =?utf-8?B?U1QzelcxK1c3dzN1THJ1bDVNcHFRdjlPWHVQUTNIZm8wR1JrNEJlTE0vYjRK?=
 =?utf-8?B?akp1czFBalZ3NnJuREtORFNxbW5HOCsySlFOd2hZaGZhS0luTHRZUFUwM3lq?=
 =?utf-8?B?NUZIMFpQKy9QaUVpWVNvZDBzT0luMWpaQmtFbncxUkhGYlpDTVpDN240eDli?=
 =?utf-8?B?VHNkL0lyc2t4Z0V2VjIwdDhRdjFsUU15clBYODcvcWVnZWNEOWx5bXcvUUt4?=
 =?utf-8?B?b2MwZ2lMTXZhdnY5Tmt2K2doOVZUQXo1czZ0VXYyOW1vMC9RZ3ZTdlcrUStU?=
 =?utf-8?B?TDJjd0pkY3NUQ1Vwa2kwQk4xT0pTcW1odmxUaEJRNDJON1E3My9QVXZUSVRV?=
 =?utf-8?B?aTBlM2p4MlhDbTZmTlVlSG1lb3V3eVdwdlJia3p0TEV4VzdkUW9aSzgzdjBt?=
 =?utf-8?B?Ulo4RzlDK3FUdnFJZWRtTGt0WDBHKzBVUU14aElRNHZrR2lvN0lXL1JXNFNQ?=
 =?utf-8?B?WjdmQkUvNVIrWG54UmNxL1M2WnZ0RDRCUHUwRUNUWGYrNnVRL001cTd3SEk4?=
 =?utf-8?B?aGRIMlkxSTZJSnN3RUc0MUMzeGhJRmhOaUxJZS9kNU9EMVN1emJsNkFTeGp4?=
 =?utf-8?B?bUhTbk5oOWZGWkwxdmRsV20ySnBkd3NubVQwMEViVGUvZ3NuRGhBSkdSdWlO?=
 =?utf-8?B?Q0kvL0FYOEN4M2MrT0tXY1BMRjQ2VzdzZW9LM1ZhUkxCVjBJQkl0Y2FqNVJk?=
 =?utf-8?B?T3ZNdjl0eHczRUZJK2gwZStTalN4ZElZZk8xaWdFeHZHVzdiQmFEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cbbf70-7695-4332-ffc8-08df232a7bba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 21:49:08.3749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJWhMamvJm7NlHdaSmMLGpPfdHaQrmFKsUkiyIDc/0DABNKpu+J6H9kVkFKHtpan7YLXgjKsr9zqmOQpbhYlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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


On 9/29/2026 9:07 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] amdxdna: submitter thread hangs forever on failed device resume
> --
>
> commit 3c6d084a73c19b1b3a172be33a5eb12a9d7f8889
> Author: David Zhang <yidong.zhang@amd.com>
>
>      accel/amdxdna: Implement AIE4 suspend and resume
>
>      Implement suspend and resume callbacks for AIE4 Physical Function (PF),
>      Virtual Function (VF), and Classic device types.
>
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
>> index f180983a692dc..6a50c1499ec93 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
> [ ... ]
>
>> @@ -1096,11 +1096,250 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
> [ ... ]
>
>> +static int aie4_vf_resume(struct amdxdna_dev *xdna)
>> +{
> [ ... ]
>
>> +     ret = aie4_hwctx_resume_all(ndev);
>> +     if (ret) {
>> +             XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
>> +             goto hw_clear;
>> +     }
>> +
>> +     XDNA_DBG(xdna, "vf resume done");
>> +     return 0;
>> +
>> +hw_clear:
>> +     aie4_hwctx_suspend_all(ndev, true);
>> +     aie4_vf_hw_stop(ndev);
>> +pci_disable:
>> +     pci_disable_device(pdev);
> [Severity: High]
> Could this error path leave submitter threads permanently hung in an
> uninterruptible wait?
>
> When aie4_vf_resume() or aie4_classic_resume() fails, they call
> aie4_hwctx_suspend_all(ndev, true) which destroys the context with
> AIE4_HWCTX_ERROR (setting has_reset = true).
>
> However, a submitter thread waiting in wait_till_connected_hsa_not_full() in
> drivers/accel/amdxdna/aie4_ctx.c with wait_through_reset = true explicitly
> ignores has_reset:
>
>      ret = wait_event_freezable(priv->job_list_wq,
>                                 aie4_hwctx_connected(hwctx) ||
>                                 (!wait_through_reset &&
>                                  aie4_hwctx_has_reset(hwctx)));
>
> Since the hardware resume failed, the context will never be recreated and
> connected, causing it to block forever. This holds the srcu read lock and
> prevents device removal (causing a deadlock in synchronize_srcu()).

I will fix the synchronize_srcu() deadlock in context teardown by stopping
the hardware context and waking all waiters before destroying it.
The fix will be in upcoming PATCH V2.

/David

>> +     return ret;
>> +}
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930033233.1727265-1-yidong.zhang@amd.com?part=16
