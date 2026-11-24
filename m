Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3431606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=40261STp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FB810F014;
	Tue, 24 Nov 2026 18:29:48 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E5E10E603;
 Tue, 24 Nov 2026 18:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMbqxIMAE9OdYQZfrzDHVBPzKPq2lw0Ns94jqJu7wc5B9tUJavkhQdORPv+/gG045fjOKARWvuq0imxW1GQHsPoiy7okhR2zw6ORsUa0R/4xqHOZPnVn+XTvwa1+odwLogqc+Vb+NWEnCz3ABRdEno8vmpn7zQIFTcEFI713c7+HEsji/9fBG0x6aCLnGad5IL6q6QqsvCObx6Kkv9YL/tH1d8NeZETJlAYDfXOCRpjlS3R7bziuxm9ge+15GVB60LlmMl2uUgM93T3wOq8jtLx++1fG8UGLoju8gfNPtZTydRJrzdDcqQuE3jdY+0aftD2YQhzAteqO772V03xVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYP7BaYqtO4FeeS7+kF/vBGaDrl3rsh94iq1y/8UuE0=;
 b=WDPe7sqpO6mvsQ01/2pWKiq1skWLzPe43AmEws8UjpvDLsi74JYNeB+TyWWpGM5qu7dHjWZW7IFWjb/tImedLmci7fajnUO1IwCtZCKpbUm/sk9oDUz4QMbMiY1Ruu0/cXoIN22lvl7DdCnhfjXX/pSXptgYF/2SmJ7PM/m9mAdN2ZJv0P+AC+cEuUdSrsmT/nwGNw3CkTuI6/Rws10iDY8EfB2NKTL/cK9drcffx5HmEavIBOpeJmm+FyYH0IwvvFp8mlTiFHEIWr7iBDWciyzJ/CQphSR/taIvxxhUQjMqVHjgFCBlQ6Pbz4g18cpuHqjixFFH37SM+1N12Z+tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYP7BaYqtO4FeeS7+kF/vBGaDrl3rsh94iq1y/8UuE0=;
 b=40261STpOf2fDkDCbEfJUD/ZpkSOqt/Qaco37AEGTDRjVO31zJ/O+3L+ndlcjZT1HzY5RRXUH6izEo9aBkoSM1jwNP3oyC7hiz9sv5oe7ZFsLXmFSV9tbPR64SHws04Cac4kMWBMrm7Y+3WYKOb9BerDsFAVvJDp7I17dg9kKVY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by IA1PR12MB7638.namprd12.prod.outlook.com
 (2603:10b6:208:426::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 18:29:35 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 18:29:35 +0000
Message-ID: <a1dee5ea-2a50-47d3-9a81-eb1a94869815@amd.com>
Date: Tue, 24 Nov 2026 13:29:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amd/display: Skip flip_done wait for
 non-modeset TEST_ONLY checks
To: =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, amd-gfx@lists.freedesktop.org
References: <20261123220913.937402-1-jakub@okonski.org>
 <20261123220913.937402-3-jakub@okonski.org>
 <47ee6326-08ca-4dcd-866b-3a543cb15665@mailbox.org>
 <4daad602-10e4-4cd6-9cf9-7f47f77a7922@okonski.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <4daad602-10e4-4cd6-9cf9-7f47f77a7922@okonski.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::17) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f223a29-1b2b-4aaa-fb7d-08df4a58e3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|261026121527099003|56012099006|4143699003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: At9DKeGDpJM95AEbiMfhN5ns1QSAytL+6Iil2o3C8LohOjm2kx2FhdhNBygB+NlsAcS5u7qjUFo42rDol9CKO8aVQ4S6KHSbXiyy6WsRGO6Kn5/93WNOkzywHcX2CF10xf1Y+4B3PX+dHdAQ77KKKE+x1BtO9rwgi8l5qPx3jQQob7vWx0V4F3BF7v1KCzQb9whEgsg7m4vVKLxSJs2QyCPOFrPHH8d2Pjndo4FdGtSLbzc3XTX9GntB/bgGkvk8dph5iYGosySU8TY8yJVPxg+T4ReQaFnkET9E/hP8LAtcWBMV32/Ek8XuZZmom1ryDAW8IN8ZUxtStg/UCEnSxA83bj/dM5hwIYXLoXgnuJQGB0NHr+uJCAeeBvgaqYf3lO9H9zc9X8vlnNKKcs6Zx5PRsU66nAqqKVVZz0KRZWxqJR5A1916T3ObY+Lw3aYI+Q4XpEH9kAXilJbpY3zEuhuTRhZtBRx9rTw0oFSa8/nBqnCl0jVkgstR8S/Ul80VPiEhUpgFXOpziBy0GHuZOwh3UfgSKAp/IYDX/eFBzu5PK+dx/y2q5MAJht4cELIsXFUUORLxEHz+3mCgKcuYIKLYzRsAtS6s+7lSkQig7771upAzQZ561kke891Gceyqu75EC/6i4XhNVBdaEylYcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(261026121527099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBpVXFzSXBWajYvam9ra0UvRjE1THZGbnpkVXppZ2N6UGtWOWFhRjZsdnBI?=
 =?utf-8?B?ZGhobGU1MzZyenQ5ZlA5R0tOUUkyVXF4MDQ4enhFenRLKzcrNGRkQnpaUWFn?=
 =?utf-8?B?NDdpRHk0OTYwNGE0MkdtaUV4ajJrSE9aa1oxcGd1QUg0ZWxUeUljYVBuSU5D?=
 =?utf-8?B?d25TSldWMkIrbTJzakphTjNKUVJpN08wUmk1UUJMVDZ5VXlsQ0xwSGtYa0VU?=
 =?utf-8?B?b09wdFpIZzc1UFVycExYNFNOc01OVjNJNWJua3g2aXdTMzNMcGF0UlB5NkIz?=
 =?utf-8?B?ZmRvNC9wcThMYVJUbWFGVktYeTNvdUZnODY1ZUpxb2VSNDM4Zk1OQ2NYQjdG?=
 =?utf-8?B?aFYyUU1sRXlLN0xoZmQvUzlOR0wxcmwveWZYeXFkNUhpZmV4MEhoSkhMQ2pG?=
 =?utf-8?B?UUp5OWxhTFNTRVJrT2pDK1RFaGRaOElPN252ejV4WmxmUWVlZVlUVGZBUGk3?=
 =?utf-8?B?SENKWnRKbm13VDFXSHR1dWR3SFJNQnFqVlczWERjMkhIbWRUV2JDbytDQm9K?=
 =?utf-8?B?RkxHQjM5bTN0ZUZ5ZFBMT0MzK2FVY0lGWnQzdjVubFRoQm1nK2ZBeFp4QWJ6?=
 =?utf-8?B?L0laaXpVNmJQeWtmTlZTc1NZZUc0V0Jac21jWitEUUFBL2JPS3piQkxsUVA4?=
 =?utf-8?B?MzlGNVF2NVIrY29RcUhOMVdPT2VGWGFUTkRhb3pBbGY5RUx2Y2NmRWQrQStM?=
 =?utf-8?B?YzJKa2pnc3YyWjhEYUh4MDByd1lPVlc4UkxoYnZ0cnF3anlZRTk3RDUveEY3?=
 =?utf-8?B?blYveUdqVHp4UFRFaXhQL3g4VkExSzB0YmRrZDltODRSOVBYYzg2b0ptN1Fs?=
 =?utf-8?B?ZkxmcHJ3WjFDWEdzeTB1TUNzSWxzRGZDdHcyQzRja1dLZkRwT2FnT0pJK05T?=
 =?utf-8?B?SjZZTjFwQSt6WU5CN3dTeTZaUXFUd2o2aHRnMXFHK1ZxbXl4aUFDa2FHWmVV?=
 =?utf-8?B?NHErMUFJRDhscTg4Ynd4RzBCd1F1ZzBPOC81cWZXZ0hCWWdCUlRMb1Qvc1kv?=
 =?utf-8?B?VGhqenBvRGROYlpvOUhueFlDMVIvUG5KYXhyT1hTU2JkM2VVUWNnSERKaUVq?=
 =?utf-8?B?ekFmQS9KK2svTGJRQXdxdmYybzN2ZXlsUjhYbHNRQ25wZ3hwY0VSS2QxbDB3?=
 =?utf-8?B?NEVhUVptOHBheEdSN2hDcXlodjJSK1QyNklXNW00MHB1TXZhL2ViWU5CQ2V6?=
 =?utf-8?B?YVZaQ3dZRUcyN2FBaEdRU0YwRG44U2JGKzlUcGNTSDlTNEFseVFWMjVyRDdC?=
 =?utf-8?B?VExKYW9ZRjVEZ2M2b1p2OUVXMzVMYkxKaFNFRGtCOVd6NmV3MWRhaTRUNnM1?=
 =?utf-8?B?ODd0ZnRBdnRZcmZUcGQ5a0hTQ285K1lBbmVaZFRZUVRyZ2R0U2dUSURvdDYr?=
 =?utf-8?B?ZTdFODIwR2lxVExOTkdPeFl2NUozMnVockhIOVlzOWZyemk3V1AyRkRPVnFr?=
 =?utf-8?B?dTZLYUc5eDQ2VnBkT0R5aUI4MGpKaEZRYkdKT2ZWMWdvWVJ6dmE5eXlPMDFM?=
 =?utf-8?B?MExPeXM4VU10dEtGQkNzVWhkVE9idDhZaUY0T1VwOHRtOUVlZHRVZVRZbXJS?=
 =?utf-8?B?UTJRRTJCRzJqd2xVTUJkb1drNlFRZ3VDaHFwc1E1R0swcWI3SVpjYW1lZ29s?=
 =?utf-8?B?YnNaaE0xYVZpcnY4R2t5dnFyOTROKy84dklDdEtqQ1NCdC9vMkpMc3p6eXpV?=
 =?utf-8?B?N2sxUGxaQjVEN3gwZUQvemMvNTBPRzNidkhlUjlrWHVhWitSbUJFYkQyaWl2?=
 =?utf-8?B?ZU93TUsyQTVSUW94YXQxclhnMHMzSUdHYXk5Z0tlMmZMN090RVAwVUxQQ1hC?=
 =?utf-8?B?M3lHRzZWNS84R2JtR0wrTnlUb3U2QnJrUUc2dGZhM3IvdW5jMDNVTFVIQzhO?=
 =?utf-8?B?Yk9pcXdJbU1iQThLOVk5WUE4UXYxODI3WEgvS3VhL1JMZEVwamc5ZHlSSTJW?=
 =?utf-8?B?Q3lWUXg2U0lnZVZlaFY0QmRMU0tMUEVoQyt3SGkzVklCT0Nrd2l0VWlZZkpB?=
 =?utf-8?B?Q1lvSFRVbzFGRGFyOURGa1BGZ1JIUEtjRkV2MmVubmJBcFI3UGtwTWpBQURH?=
 =?utf-8?B?U3BzVWZWS2Z0Z1BsaEpqRUM3QXVLZXgrREJscGcwenZhWlgyOHlxZUpteDk1?=
 =?utf-8?B?cFNZZXZtRzdnUW9aa3U3MGJpK0NWMXRnNSsybHZJblE3UEgzOFg5NUF3T1hZ?=
 =?utf-8?B?TFdUb250RWt1MTRoNnExZ2U3RndBTXBpUVBtN3JZSitMYnd1d2FPell0QkZS?=
 =?utf-8?B?YkFPTGVqVUcrcks1M1VtRm9zeTZGYlg1V1lSczdOdVl3ZVJvM1hFcVhZZGxp?=
 =?utf-8?B?VXlzUWpLR084WFJTbkxMb2o5Uzh5VjVhOUlhNENnWDJnbVYzSTl4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f223a29-1b2b-4aaa-fb7d-08df4a58e3d6
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 18:29:35.1502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7VugSQHs+S3mFb4nSgsY45A4MvDObI6zHbnDD9Clo6DugZri7WPAC9ivXQ0b1ofx0EBLus6Y6EEAerItLSe6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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



On 2026-11-24 09:07, Jakub Okoński wrote:
> [You don't often get email from jakub@okonski.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 11/24/26 14:05, Michel Dänzer wrote:
>> Does a commit with both DRM_MODE_ATOMIC_ALLOW_MODESET & DRM_MODE_ATOMIC_TEST_ONLY set really need to wait for pending flips to complete? Why?
> 
> I was not confident at all and tried to keep this change narrow. It's
> possible this could be relaxed further but I have not tried it.

I have a branch that removes the need for that stall in atomic check and 
passed the work on to someone else for validation and review.

The problem with the existing code is that IRQ handlers reference 
in-flight state, especially dc_stream_state. The solution is to decouple 
the state the IRQ handlers need from anything in flight. But its liable 
to break things, hence I'd rather be a bit more thorough with validation.

I hope you'll see patches for it soon-ish.

Harry
