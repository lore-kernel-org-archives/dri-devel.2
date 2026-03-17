Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9820FB5EA8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1922710E2DA;
	Tue, 17 Mar 2026 03:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="jNoRx4WK";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazolkn19010073.outbound.protection.outlook.com
 [52.103.72.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D0710E2DA;
 Tue, 17 Mar 2026 03:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAPA0xh4oFt2TiaFGOaeqJ4l5Y3V4EK0APc50JeQPwOAtWqNAOJhub3KzLF9L7+I8CaJfxvBj2WEyCOJ614HfmikkX+x9CJRxHTZFTUfgR645schS1pvweyhyQhjlJC28ABFQmIIXnEF+I6jkSJb50+Y3OYz3HZCeFQ6mhwjizJxencyNy60VmRc3V9ha8OyjwC+uwriucQlu5Mx8V+14Dj0VjfFRsleb+SGXZQ4b0qNiFLspsemYIlOvW5UcPijTB8HBOhYWaaHG3FCOWMzYBtElBrhSz+W36U1c7zuxkHFWIeENeVweXvTW8jwVajcji+zwB/GYhnfdV8ZvsMG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFXM5P4q7n8kTcG4vRUrwSmRbH0UQ5LhH+6tkLONhNQ=;
 b=wMRomeH3SwABGRlXZEd5Z8P47sMRdqgGeCiyus/q1pxejYhNkEK+Dfsw8Q/YQAbstQ968CkiPsJS6V3+qusB5214eUo3fVdBfFZub9bWAwDdYyaHxUrj0jo+ezaFIYiF1yJzKSXx0l7XKXqZYs50grBljZjcWbGeNrA4y7uPf2s60EzqDSZC89C/HV8Vj7+ARRzIPFdQW5iQBdZKhh/Zwci4Doij68Qj/mrOpuvDZEdBzmgTrI6wuyYfNzdxy0TLPYZC4k6fXGyP6AcjP3wmsc8/xRDpbscievIU7CvmSKr1yzvL6iA7O70s0I1SN4Q/wKANRH+ZNN/ILJ6mhZVk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFXM5P4q7n8kTcG4vRUrwSmRbH0UQ5LhH+6tkLONhNQ=;
 b=jNoRx4WKb1hN7EWAw1jrW8fR45cRl9gzmUfEd2oW8meNM4+/4/YyE948vvs1cFx7Ypi23RPBIUAwc7tfH7wMelZtcNBQoH5zPIQC8fknAUZnUfYYoTk9VnBSDRBuR3mK1IeuxvZIzSwjSNQVBOFtne+RNQfMDhTgfMBlVT6BxXm9FCp0l+HIp5VU+9f5BwR1bKx8bHC7PZuMeJc9H60JgBuY6ewcEXBLm90/G4z/GPyMyMSkiSaZp2hInWYLtyGFdPfFLir0AJ4zzmeTEqzo7uy6CY3lWPyR6ahm1ggrvi3gHjRZCwgfYXtL5jlax6VMntO0fnbhycsiVLoYK3o+9Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB7115.ausprd01.prod.outlook.com (2603:10c6:10:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 03:16:14 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 03:16:14 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 17 Mar 2026 11:14:50 +0800
Subject: [PATCH] drm/amdgpu/userq: refactor MQD init into per-IP helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <SYBPR01MB7881D8124681BC48D009E222AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nz3bTMitRi3WQLg7QUM1OLZPMUUyWg2oKiVLAEUGl0bG0tAOEb91x
 XAAAA
X-Change-ID: 20260317-fixes-c80fd658c7d5
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Liang, Prike" <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7837;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=lEJK+hppw3xTpgIZfNN612BGZla7z1Jn+bsQnuiWY/w=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhswdxzWPdL/z8dOZbbqkpORVpE3dYV7+7qOrj6YU+5op2
 v/5EtrQUcrCIMbFICumyHK84NI3C98tult8tiTDzGFlAhnCwMUpABOZ/ISRYVWhrIekcIz7Fd9z
 ZrasDloW1SkROb8X+8XXTn83c76DGCPDa7PqSRK5Z6ar2fUueVQwd+HzKjOWRcqJPM2uga4Hps5
 jBgA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::7) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID: <20260317-fixes-v1-1-0feec64edc30@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdc0760-a5ca-4151-1d11-08de83d38b6d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19110799012|12121999013|5072599009|8060799015|5062599005|15080799012|41001999006|6090799003|461199028|51005399006|24121999003|22091999003|10035399007|3412199025|4302099013|440099028|12091999003|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkxHek0ydmVWYWY4WGIzODlrallKQXNtWURXNTB3VzcwYm1CNjgyR3V6eDVD?=
 =?utf-8?B?ZGNENUllWEJ2UklnV1VUQWJzK3R0S1JYVkQzLzFvNDJ1eWxxbDhodGZnNWFi?=
 =?utf-8?B?blhjelVNYUg3S3ZoS2wzZWNGeS9yUWhERTBhWGtQdnlRcExqVWs2V1dLNE1S?=
 =?utf-8?B?UFA5Mk1WYmxxR2wrVzJwRzZmdDFXek9mUVVNSUs2MVpyMjltTHNDbi85YjFa?=
 =?utf-8?B?ZWlkcmlSa3B2akxmVGwvc0t2cHQvQWJoSmJUeXA0aUhXaEdBNkpkUlQ3ZGoz?=
 =?utf-8?B?M0s3alpYeTJ5MDdJRnlGZHM3WUtZd1pQWm9tY2xhWG1RODlBeXhYVG5hc2R5?=
 =?utf-8?B?OVEvL0I2cVM0V25ySUc0UGZqZ2VMMzBKRUpTSCt5SklsRDl0YmdzaXdIYkho?=
 =?utf-8?B?RWZiZ3l2TWRVYWlPYkF1WWwyQ011cENPdE9hSmhreUxoMVNMb29MZTgzSVFG?=
 =?utf-8?B?QVdpb1VNNWs0TUNiTldBaCs4U0xSME43YXRPYU9vVlNDMDZMbDBOQUdvZG5K?=
 =?utf-8?B?RFJITlRxalJ1Rm5yL2xHbWozcGNManF2RXJKNTFjbzNWN21aQU9RMEFrQXhm?=
 =?utf-8?B?NFdhTUtoQVJuZHlNV3BkUnRVdm9MSkNkMmVvRGxRR2tlQmR6aGE2Z3R3QkN4?=
 =?utf-8?B?NGlUZmkwQ0pkM0ZrdHM2cU1zVTVTL1hsZjNBN3puczMwS3lESThwR2dCQ0hq?=
 =?utf-8?B?SVdTNHdoTERFUERhV2NZbkRKclhBU0w1V29NZjdSc3hyZjgxcHZzMWl2UTBL?=
 =?utf-8?B?d05vZ3d4MnVPTW92MVBKZ2w3YkZmNTEzRDhXRGJKb0NXOXlzcTAzdjk5OTZX?=
 =?utf-8?B?dlJsZDZMWUFtMXA4NDRaeUdYZjVZYWtqZE9rL3V6amxQQytrMmU0UGUxamhM?=
 =?utf-8?B?TEhvN2NBM0s2eFhZZUY4VnRNV2liVDkwTjlFdDdaWlR3Tk9BTjNpUVNaSWJj?=
 =?utf-8?B?bXVvdXFCaVh2SWtOaVd6dG43OEh5SXY4SnppVDBUYWt0blM4Qk1Uanh6Sjhk?=
 =?utf-8?B?TWJwKzkxWW9WTGh1c2dCV05iWWhUcDBiL2xldDlUZkN1VGpGd2xEWGNVTVh4?=
 =?utf-8?B?bFJlQXNZSjhOZUFKR1AxVDljSmNEWnZKdUNyMEg3UVlXN2I4dGxJOHA4Y0lT?=
 =?utf-8?B?UHRpS3FtbGtZQ1RNRUJrV2lueGxuM2R6L2pkTS9lTUFFSHZnaXdqVXlqVDYx?=
 =?utf-8?B?NjBic0pLWk03MGFwV2MrWlZvUWcvM3JxcGl6TVdPdHJhaTJLRlRiZmNKaWIv?=
 =?utf-8?B?MklZcmVHYnYzd0RWenpUODY2WjBIOHRMTEFrSGxiVEVGTWdpWlcxajZvN3ph?=
 =?utf-8?B?eEpqUm5KN1ZGM0JxS2w3OFJHV0hIMHJUdFgyV2tNamxwaEdvaEFTTExNRHJ0?=
 =?utf-8?B?eStTQkY2UWhMTHY1ZllJTzUzc3A1VUR6d1BDQzFKdy9HRFlveW8wamZwRzBw?=
 =?utf-8?B?amNlbzg5dGZUdGlyTUFJeVMwb2h4cUlwSlYxU21GTW9mcm5PQXI4bW1wU1ZM?=
 =?utf-8?B?VlIzM0lneFZadkswaUQ1QWF0ZkNEL2JFNkJlTUFIa05KU2g5UUdNbjhtaFVD?=
 =?utf-8?B?UzJhMFJhcUt6Q1FqbWQvUHFqUzJha04wdFc0YmtzUStJaktWc0pseFd6eXpE?=
 =?utf-8?B?WXpkVDZjMkJHZ1JzQk1VMThYS3oycGthWUdzM2ZkOXY3RjRlL3M2VmVZY1VY?=
 =?utf-8?B?T2ZGQVdKMWhXSVJra3k5Q2JZNlhVRFUzamREbEZkMnkySXBiUHR5dmdBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2wwRWxPYWJFUGJodCt2aUVxbG9qMk9SVFRHQk9yYUZ4cEVxaGpCV2d4WWJn?=
 =?utf-8?B?WWt6anliVHp4UUFrSEFvTnJ0aTY2emFXclRUWDVPNEdVQXFGcUFJbkhqbHpp?=
 =?utf-8?B?K3V2N2hUZEpEOHJ0WU93VS8xcWMyK1FYQVN2OStTNCtOZVpzUkhYTnVhd2Ew?=
 =?utf-8?B?ZTV3dmE2TDQ1UURkOGJ1dTJ2b0pxTkE4aWtYWGw1RFdpMStlSzZKQmtZV29X?=
 =?utf-8?B?QVBYcVlYdXRNWkVWRkpJWFJGQklpQVZJODNNRm8yaFVJSVhHN1ZvVUJtdDN0?=
 =?utf-8?B?eTRwdnBud2FjNWxoL0MrUGRDb2o5YUFDN2NXdkkvZXRNOWJBTE02a3A1eUJK?=
 =?utf-8?B?aDY0SmszOFROb2FjNzFqSUFOY1RIZlBLTS8wZURHWmFudDZUU2VBeC96UHVC?=
 =?utf-8?B?cC9rQUdaS0JpWGJmWkNvVlhiSTc4TkRrUkhvZEhleFJlenZveldOYWhtUVVm?=
 =?utf-8?B?LzcwWjJuSytqeDBTYmIzVnQ0M2lDeGc3QkhSSlpKVmxGMnBzOGJ2WlN0TmRr?=
 =?utf-8?B?R3A5QWtTVDVsckdSa0MxQ042QW1SL29HaUxKZ1pMT05INTZBVTEwYmtmTVBp?=
 =?utf-8?B?aEVEUjRpYkVkTDUxd3EyZkRLc2tWUUZNZXNrVUlJRWRGN2xrL2dKL3RmMnJj?=
 =?utf-8?B?ZWUzS1lGYnN0MmFOYkp0S3EyemZhbXJYaUNpSUtQQm95L25XalBxN3VudDVD?=
 =?utf-8?B?VFptKzVNMmpzWERSczhRVms4L21ieWxRdENtWjgwSFAxdnhyY29kZy85Vndh?=
 =?utf-8?B?UlFMWWh6WDNZYXB1WTJwd293YlZGZjBaY3NQdFE5YkxBakk1WnBzQU9NMmI4?=
 =?utf-8?B?aHB4RVlpd3VGaWx5bDJlWmFuWHVQVUZyOWtuZDRpRFBwbEJhYUhwK21uK0Jy?=
 =?utf-8?B?T0pLcGRWbC82NEIzcC9reW9QbjdEeVQxeGNZVTZ2ejJkdzl5R29wbXdEOCtr?=
 =?utf-8?B?cUQ2ZmNBOEc0OVI3UWlxaDMyK21CaktZcUpydWUxVURoMGJPYmMzalptNWta?=
 =?utf-8?B?MXlKVm9LNzlPbFA2c0hwc3R4RWczZFRHV0JJU2h2QVRaMGVRZkxMeDJYMGk4?=
 =?utf-8?B?bHpCaG94RUhlQko1ZjJodlpRSjJDd1dwUE1mQkpZcmdiQlRCOE1JSVhwM0JZ?=
 =?utf-8?B?WmkvUS9JSm9ETTNQaUZYWnFkQzNKM2VQMWIvNDAxNEliSk8yZmNkZ3AydHhM?=
 =?utf-8?B?eUpGdGFFOUZDc3FQa05ONGJSQjFSZXE2WllLUkNOQ25aWmUxa0l5bWJWWll2?=
 =?utf-8?B?Y1IvWFJGczlvTXZrZnh3M2JZbmY5REVjTDlFVXd2cGtGTFY5K2VncDRjRFN4?=
 =?utf-8?B?bUhkR3k4enFSSWtBT2tLUDU2eWU1WG5rUlBjRjhTcXh4ejZlL3JMbnJCTkk3?=
 =?utf-8?B?MHNnMEpvUWM5TElqbldJcWxSQ25QMEpka0JTcVJLQkdLRkxpdWFkS09nRE81?=
 =?utf-8?B?R3hTV2dQUk9vaDhUT3djR0crTDZkaml2WkNpeGd2M2xROHdzU0tNTFcwMDll?=
 =?utf-8?B?dDBuVnJYZzdvRXdjRXJJemNHOVBvSEdMd0tVbDN0cEtZcnVLT0pVSUFpbERy?=
 =?utf-8?B?dWZ1cmVLeEc1Ym01UCtWZWRjVUxJZDdKcVBUVXBsdnBneEVkMUlSQjk2Y29F?=
 =?utf-8?B?dVlpemxpbjR0blhWZTFnZVJtK2lVbjFFY1dEYWMyQ29rb0dhYXU3WE5FZU1r?=
 =?utf-8?B?REpZRURKb1EzYklDNG51T2ZndnBEUExhb2ZFY2ZCVTg5L0VtOU5veWZYaHVh?=
 =?utf-8?B?aERRa2VGN2dGblJ4ekloUFRrQjJVUTd0YklQYTVPRG45RFFVcG5FOWpoSFE0?=
 =?utf-8?B?UUY2VlA2MldscEY3YUloSmdMV05MM3gzdlk0anBpR0JiRm8zV2o0OWZkV002?=
 =?utf-8?B?Z2pNeVF1ZXlNRHFGaGZOb2RrWFFXZ0p1WnpsQVRrWlFOaVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdc0760-a5ca-4151-1d11-08de83d38b6d
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 03:16:13.9774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB7115
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

The three IP-type branches in mes_userq_mqd_create() share a repeated
pattern. Extract each branch into a dedicated helper function and
introduce mes_userq_mqd_read() to deduplicate the common
memdup_user + size check logic.

Each helper uses __free(kfree) for cleanup of the memdup'd
MQD struct.

Link: https://lore.kernel.org/all/SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com/
Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Suggested-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 205 +++++++++++++++--------------
 1 file changed, 108 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index faac21ee5739..0d7ccecf7c1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -272,6 +272,105 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static void *mes_userq_mqd_read(struct drm_amdgpu_userq_in *mqd_user,
+				size_t size, const char *ip_name)
+{
+	void *mqd;
+
+	if (mqd_user->mqd_size != size || !mqd_user->mqd) {
+		DRM_ERROR("Invalid %s MQD\n", ip_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), size);
+	if (IS_ERR(mqd)) {
+		DRM_ERROR("Failed to read %s user MQD\n", ip_name);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return mqd;
+}
+
+static int mes_userq_mqd_init_compute(struct amdgpu_device *adev,
+				      struct amdgpu_usermode_queue *queue,
+				      struct drm_amdgpu_userq_in *mqd_user,
+				      struct amdgpu_mqd_prop *userq_props)
+{
+	struct drm_amdgpu_userq_mqd_compute_gfx11 *mqd __free(kfree) =
+		mes_userq_mqd_read(mqd_user, sizeof(*mqd), "compute");
+	int r;
+
+	if (IS_ERR(mqd))
+		return PTR_ERR(mqd);
+
+	r = amdgpu_userq_input_va_validate(adev, queue, mqd->eop_va, 2048);
+	if (r)
+		return r;
+
+	userq_props->eop_gpu_addr = mqd->eop_va;
+	userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+	userq_props->hqd_active = false;
+	userq_props->tmz_queue =
+		mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+	return 0;
+}
+
+static int mes_userq_mqd_init_gfx(struct amdgpu_device *adev,
+				  struct amdgpu_usermode_queue *queue,
+				  struct drm_amdgpu_userq_in *mqd_user,
+				  struct amdgpu_mqd_prop *userq_props)
+{
+	struct drm_amdgpu_userq_mqd_gfx11 *mqd __free(kfree) =
+		mes_userq_mqd_read(mqd_user, sizeof(*mqd), "GFX");
+	struct amdgpu_gfx_shadow_info shadow_info;
+	int r;
+
+	if (IS_ERR(mqd))
+		return PTR_ERR(mqd);
+
+	if (adev->gfx.funcs->get_gfx_shadow_info)
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+	else
+		return -EINVAL;
+
+	userq_props->shadow_addr = mqd->shadow_va;
+	userq_props->csa_addr = mqd->csa_va;
+	userq_props->tmz_queue =
+		mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+	r = amdgpu_userq_input_va_validate(adev, queue, mqd->shadow_va,
+					   shadow_info.shadow_size);
+	if (r)
+		return r;
+
+	r = amdgpu_userq_input_va_validate(adev, queue, mqd->csa_va,
+					   shadow_info.csa_size);
+	if (r)
+		return r;
+	return 0;
+}
+
+static int mes_userq_mqd_init_sdma(struct amdgpu_device *adev,
+				   struct amdgpu_usermode_queue *queue,
+				   struct drm_amdgpu_userq_in *mqd_user,
+				   struct amdgpu_mqd_prop *userq_props)
+{
+	struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd __free(kfree) =
+		mes_userq_mqd_read(mqd_user, sizeof(*mqd), "SDMA");
+	int r;
+
+	if (IS_ERR(mqd))
+		return PTR_ERR(mqd);
+
+	r = amdgpu_userq_input_va_validate(adev, queue, mqd->csa_va, 32);
+	if (r)
+		return r;
+
+	userq_props->csa_addr = mqd->csa_va;
+	return 0;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				struct drm_amdgpu_userq_in *args_in)
 {
@@ -306,104 +405,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
-	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
-		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
-
-		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
-			DRM_ERROR("Invalid compute IP MQD size\n");
-			r = -EINVAL;
-			goto free_mqd;
-		}
-
-		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
-		if (IS_ERR(compute_mqd)) {
-			DRM_ERROR("Failed to read user MQD\n");
-			r = -ENOMEM;
-			goto free_mqd;
-		}
-
-		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
-						   2048);
-		if (r) {
-			kfree(compute_mqd);
-			goto free_mqd;
-		}
-
-		userq_props->eop_gpu_addr = compute_mqd->eop_va;
-		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
-		userq_props->hqd_active = false;
-		userq_props->tmz_queue =
-			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
-		kfree(compute_mqd);
-	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
-		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
-		struct amdgpu_gfx_shadow_info shadow_info;
-
-		if (adev->gfx.funcs->get_gfx_shadow_info) {
-			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
-		} else {
-			r = -EINVAL;
-			goto free_mqd;
-		}
-
-		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
-			DRM_ERROR("Invalid GFX MQD\n");
-			r = -EINVAL;
-			goto free_mqd;
-		}
-
-		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
-		if (IS_ERR(mqd_gfx_v11)) {
-			DRM_ERROR("Failed to read user MQD\n");
-			r = -ENOMEM;
-			goto free_mqd;
-		}
-
-		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
-		userq_props->csa_addr = mqd_gfx_v11->csa_va;
-		userq_props->tmz_queue =
-			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
-
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
-						   shadow_info.shadow_size);
-		if (r) {
-			kfree(mqd_gfx_v11);
-			goto free_mqd;
-		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
-						   shadow_info.csa_size);
-		if (r) {
-			kfree(mqd_gfx_v11);
-			goto free_mqd;
-		}
-
-		kfree(mqd_gfx_v11);
-	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
-		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
+	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
+		r = mes_userq_mqd_init_compute(adev, queue, mqd_user,
+					       userq_props);
+	else if (queue->queue_type == AMDGPU_HW_IP_GFX)
+		r = mes_userq_mqd_init_gfx(adev, queue, mqd_user, userq_props);
+	else if (queue->queue_type == AMDGPU_HW_IP_DMA)
+		r = mes_userq_mqd_init_sdma(adev, queue, mqd_user, userq_props);
 
-		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
-			DRM_ERROR("Invalid SDMA MQD\n");
-			r = -EINVAL;
-			goto free_mqd;
-		}
-
-		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
-		if (IS_ERR(mqd_sdma_v11)) {
-			DRM_ERROR("Failed to read sdma user MQD\n");
-			r = -ENOMEM;
-			goto free_mqd;
-		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
-						   32);
-		if (r) {
-			kfree(mqd_sdma_v11);
-			goto free_mqd;
-		}
-
-		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-		kfree(mqd_sdma_v11);
-	}
+	if (r)
+		goto free_mqd;
 
 	queue->userq_prop = userq_props;
 

---
base-commit: 0079dcb07e98346c0722f376ae3436cd28a71fdd
change-id: 20260317-fixes-c80fd658c7d5

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

