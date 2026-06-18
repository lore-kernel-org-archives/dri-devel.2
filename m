Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8577FCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E664310E576;
	Thu, 18 Jun 2026 20:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Od2L6qDc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5A210F3E1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 20:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR+ggVwTurwYzsfCDbRAIeLm62Wcj+D90JdHJOyOn7t9EvuozdR6xxRVPyi9bFb0HuT5nKAlfvi8ouSDxq6rC0eIcKzM8ef+u6FCmlNhIU9osfaE9j8VBgGnRe1B/q/P1vzWh1Z9j8qf5jOoiPYRDohHMeZmbEr56c8be/Q21m9iGRA9BUnSgQBHgsBBUwhQmnpkGIKJbsscbq0vABDUMehKLX3TBCKGm5Yed4DcqlVFnfWZ2GwcgsgsIEdMMsTzM+eOpomsK1dqe+pSNwnf7suCZ481H/17OR1FUkWiSWNUJZg0RnaL2wvezkdzgkkL0IHUS1gvSLyIVZW0q0/GDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aU+OeFqWEQtlaKphqXM9ifyMJoIB9LkYt8N2cJmdns=;
 b=HJBlMcC/+V0+PXvJq9QCte3cPHS/GFwJQKjT00gg75H3CY3l/zs8pAeEBwRgrh4cfymvvQDJDeiZQnFupFUk4dLskVmNEa6oRJzT75WBWQchdXow9hk0MDOYAJhnxjSeyJcWzfEZcl1QNof5b/t+icCSvg8zwnNcgLdDwucXb1wopUi/jQ+X3Obu8F/+YZJ0su4F1jrEzKuh5fQ6hrFM8Qt906hVGWtn02MeL8EScMUgTAUpVQO99TPdhxLQFs4Lx/ca0XNeBz5Dxk0SnjKMrJKegOpjHeAPdPwhYnKSFYOLydxwDaN36J7IgYfoARiNg++IE7sO8Wul9bRPgGfdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aU+OeFqWEQtlaKphqXM9ifyMJoIB9LkYt8N2cJmdns=;
 b=Od2L6qDc1B5owEPezr/9wXDJSnFUAmT4CYarJ0OjwIOH2lw3BYDizxQtI/Nq2o9Zb63baDY3miNai70Jt146DpRRSwRqLqHQi+q2EmaY4i7n08elMntHonzgWqXxnmxmm8OybRR7mgLA0H6O2zEJhLff/6ooLcsIab7Jid2dnGc=
Received: from CH2PR14CA0056.namprd14.prod.outlook.com (2603:10b6:610:56::36)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 20:41:19 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::5f) by CH2PR14CA0056.outlook.office365.com
 (2603:10b6:610:56::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 20:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 20:41:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 15:41:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 15:41:18 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 15:41:18 -0500
Message-ID: <1527e77b-5ae7-4c82-94d0-a1e204a487d5@amd.com>
Date: Thu, 18 Jun 2026 16:41:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] drm/amd/display: convert GPIO translation logic to
 lookup tables
To: <dri-devel@lists.freedesktop.org>
References: <20260512190019.228440-1-guilherme.bozi@usp.br>
 <CAJgF-xu=wPXkdSD-HwjDheSWXvokcCg9nZ3_ku12=0N9i96yaA@mail.gmail.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CAJgF-xu=wPXkdSD-HwjDheSWXvokcCg9nZ3_ku12=0N9i96yaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a13a4f8-5309-4087-558b-08decd79f37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|56012099006|6133799003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j3ARmiEPpl1rVlctz23/NphDswMMpLITsh2lCy5ddCCpF18QrscxwZLrQGWkzqi9EqMt15Mh/gdQwqo21ljv6fXV2QHwbFlSzCRGsnAQKlph3R+vfyfDxJUhlPiiOquabgl5cH6TXPKn50LmvtYHmL28i577gh1deoNTBNPs460Z38HD8JLIDyiW0Y24pAxrDBMkR1nonMeAzTzMuP1lA4INqorALTfRviY2uwBHBKlubEwCe4K/Zs5670J+AqemoJ6EStt5HPRnyb+Y0HmAyWR7SHfvUpJ/e62T7QLDmEDrII1RMrcsI1U/n2QVnADJ676kWP2cYYMYJz9mrSS2Y/luNwP0SmALFTdJn/+BgYnBXGkdf7AiyOCYng9KOW9CM12jhrO3dfEhcabY0e/QA/KU19YiW2vgy8Nepf5xFHPfbwQknNdotBpqwIQpgb5H7nxqD4n4eZyRjKwW0CtOcowG1G/ECLMpEEG8MADpMUs1GSIaIbcjQNJmMWngCkeEoCuvAot6EScy9SRjrpzxNWCqSnBtnG8mW4NKx/xP/+gxycqtnskrtj6ig70/L9SFguEaRuHi/wnUWLefRpC2JPv25od1F40PwTQK77Dk7TGHaPeHr8MAIaN3JyrXcs2TX4qBZS3P+E5GxtpexBETNgW70/mE6EdCWs/5PaP8WlQugeYlrD5gvnkulTjYZaSOUaolrWXDCdZv3pFLGN/bBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(56012099006)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B0V10Mf8mBej+biBAiJh2qb7jXLsQczFbWxsT0B9/TcCfKzTawh0SnKClx1nL2QHOEsAOPaci4xAgUSG72XUG1I9DF0B7y1fDHGKjUFHwXrlZsYAysR8UcRBDF2jQ0xziUS+FygCoexKZcCKgUFV7KNGym9159k2MprNZxQ7h7wD07WBbV0HyBgD1sCFKOXwmEn6d65wMb+GfXGdifznivNNpr9es7b9QRH4rcqChYUo3qZgw9Qq03jIBlOEzvkD5wfdb0ARYI3susd/D695RR7welqiZGoT6/leFEq/6fgqW2czSYnYTVAMhG6/zBq7Z0UogwsuA8G2t+z4Z65d5/zS/9D6qskUXZVzsfnV5tUvUQ0xmlrppeWBht7v3C2wBvXTANL56Vs8n8Q3v1QC8fiotEKDv9HkA5fSWnKx97GHb/wL4tL3qp5+XBRdWlFo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 20:41:19.2493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a13a4f8-5309-4087-558b-08decd79f37a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
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



On 6/2/26 9:43 AM, Guilherme Ivo Bozi wrote:
> Gentle ping on this series. Thanks.

Thanks for your contribution. We have merged your series internally. 
Once it passes the weekly testing, we will have them merged to upstream.

> 
> Kind regards,
> Guilherme Ivo
> 
> On Tue, May 12, 2026 at 4:00 PM Guilherme Ivo Bozi
> <guilherme.bozi@usp.br> wrote:
>>
>> This series converts the GPIO HW translation logic used by
>> multiple DCN generations from large switch statements to
>> static lookup tables with shared helper functions.
>>
>> The new implementation reduces duplicated translation logic
>> across generations and makes the GPIO mappings easier to
>> maintain and extend.
>>
>> The series introduces generic GPIO translation helpers first,
>> followed by per-generation conversions.
>>
>> The following generations were converted:
>>
>>    - dcn10
>>    - dcn20
>>    - dcn21
>>    - dcn30
>>    - dcn315
>>    - dcn32
>>    - dcn401
>>    - dcn42
>>
>> The dce60, dce80, dce110 and dce120 implementations were
>> left unchanged for now.
>>
>> dce60 and dce80 contain special switch-case handling paths
>> that currently do not map cleanly to the new table-based
>> representation, so they were intentionally excluded from
>> this refactor.
>>
>> No functional changes intended.
>>
>> Guilherme Ivo Bozi (9):
>>    drm/amd/display: add GPIO HW translation helpers
>>    drm/amd/display: convert dcn10 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn20 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn21 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn30 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn315 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn32 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn401 GPIO translation to lookup tables
>>    drm/amd/display: convert dcn42 GPIO translation to lookup tables
>>
>>   .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
>>   .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
>>   .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
>>   .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
>>   .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
>>   .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
>>   .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
>>   .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
>>   .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
>>   .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
>>   .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
>>   11 files changed, 1274 insertions(+), 2035 deletions(-)
>>
>> --
>> 2.47.3
>>

