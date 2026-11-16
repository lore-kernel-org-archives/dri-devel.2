Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBE606A883
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o9WIK9lK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C8210ED4A;
	Mon, 16 Nov 2026 09:19:06 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E017910ED4A;
 Mon, 16 Nov 2026 09:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU2Z9yNrSCq06RuoLUp+rzmr/6HAnMbdtPZ4SqtYcHl7Xk824cVrLdcJg0T1nnmOEl5vzVO6b1hwcEP0zyOQ7x8rGIahBzoLMmMfyst906hDBZ9nXpxgnKVQyo2Ittkz77GV4i4ET2nytylz1kAV6pCz48MTYmhX1jZU6vy7a2MJl8sTJlYOTApmck8CeoOzmSzc+3u6Wm/fLV8hUE6T2GgyiRfSXTRBToMy7u48PbYTAjnKiobbYmAJyDcgjqTskptutIW8sUxHPxxm2pWn5iv1kfST3ZH2sjoftApFeF/6mLhRjOu3py8cZ67ElBQVQB3pqSSGGBsAEkpiay7IjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1bNKXIs8Y9hg0zuFF6AeWiKZcBanJn0P3Rm6+aW7kA=;
 b=kPJBHKXYEhcYWHjwC3ltgbTPtD0CETnWGM9QGGXmZWIt/srI1zUloY7L7/xcEW5RmA7JLidQveXMKl99zmxqNlaDretgtooNFyS2RqGYJ52PXe63zGrul11hKLhVJKgbw8LtTM9yy4KZwjNdIhPHSi6crhIzxrkIciMqUUrkkRp0D4/YzSho3da2vkOYhJ47fSWVRI9p8ZcXmztHFmScTn/sNxOrpfjjWFIBXW4VfWi+nc8o0/WXZrOf/y7BsMU4x8AZxEs7T6ptr7rWVlziqtovXKtgnGHWfTL9cjAuCgVmQNxqOTaHsg0aqrsurqj31O9BRcM9Vt+LbhhULtM9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1bNKXIs8Y9hg0zuFF6AeWiKZcBanJn0P3Rm6+aW7kA=;
 b=o9WIK9lKTTzOv+cHCADFckz35HFDLS4RN6wa0TQoKzzsOp4F2Zbnl59kHYg/k5j012AfAxW9wilQCi+0/ToazBMDj4mcLI/N2z1gFhZUF/hgFwCApog7T5rZ4HsR81UgJ4XOaklXd+SbSexKlwclMbxAA37MrSMs0kIV2o4kiM8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:18:57 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:18:56 +0000
Message-ID: <b26ac838-2486-497c-abf4-f540927ffc24@amd.com>
Date: Mon, 16 Nov 2026 17:18:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm/amd/display: Don't force a modeset when the
 ABM level changes
To: hugo@hsal.es, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Weber <weber.aulendorf@gmail.com>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <20261113-abm-sysfs-commit-v2-2-5808d17a7e89@hsal.es>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261113-abm-sysfs-commit-v2-2-5808d17a7e89@hsal.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ceb938-1c2e-4fb2-778b-08df43c2a41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0eyxv/ZHWHxitGZK7VxG18Br0ncV3AZU30ljskrX2NXoy7X3xtXvchnV1SgZ3Nt7uvdkRHPmLjf9vGJ8OLSST93r6nuWQhslebyOSKtBIrMk4ZUH/VwsVhh7U/N0P4Vx1WvyUm+scD6gUAq3KdJIj2fsCUdoXK9AZt+6Nf3ApMjmG6A+brdPIenUYasqd0vSQsejbau8ITWK/oMC7sFAPOqmWRt2RD/bU9VnjU+9TWExTIu50eMO7rb9UTxQtNJXGYW4NWygUgR5G9jnXAwxlx7qbkqeBi85wD+le+A72HMaD6sclM6MO/Ma/iLXffqLakDAsQHe2aFdKT20+/hK7NfIUTAzJjJwffOzK+0dq6XHpwgV62fTgr7tlHd1Ki1PggTUkH0KwrU1DZ47wzDosb9YQrouyhW3URbpKiG4aidrf8ATihVCJZDRY5sAmhgMtqETHXcK9Se67T9X9uNlVd+LHg0SmNpQteejX1UvcqK742CbkPOyN8g9BRFer3Qnbh0GcvN1XVLDBKnO0If/id3ufoo4teE0blkDtgxyGbMW6ckCXxHvOVNbmEhC/jGNarTimeSR+k81F9fs/1oOoBmvfuurHhdvkYYK6GG80yg0Egl0qYPLmPX8/yOtMqu5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWs1KzZLQ3hXRzRlelZFREd4WHZVODRSeVRvalllbTJWeXVpeEo0bndKM3Bm?=
 =?utf-8?B?TzY5Vmc3YncxSExCcHNqeldEZlVBL05RVUJnNWJyU1hKMzJmY0VtWDBEM1U0?=
 =?utf-8?B?bkpIT3pQWmduWFdWQnJxYUo1SVl6ekdrQVJoVXhGb1FhK1ZyK0h5anhQRnJV?=
 =?utf-8?B?M2l3ZjB4YnIxODVmWUt2akFSYk1GT3FNN0xQM0g4UTFES2M3eCtVVExxdStT?=
 =?utf-8?B?VU1XT3pnTWdnVVc0S2Vxa2VOYWprb3VzWGEwVFU1Z0Q4WWxJdDAxM0l4aG1E?=
 =?utf-8?B?aFVodGNWU3E4YklpdkpEQUdNVmdKdzJhYzJzL2NRNThtd3BMamowbmR0RVdq?=
 =?utf-8?B?QllFTGRPN0RpTkpHRE1TQ25qeTltUGZ6aW9sZDJxYXhwMkJRaWRWV3lGZ0dv?=
 =?utf-8?B?ZWJNdEZtZ3JjeVU1aXFVbTB1OUhEMDVDWGlUMmxXQzArSnhSUFdVbG05SU9h?=
 =?utf-8?B?d0FiSVBESHhLSzk4K2Q2VFM3dXhOU0k4WmVCTGhmcFlvSEQ2TmRXU3Q5UFdo?=
 =?utf-8?B?SXZKd0JtZzMzajdyMVlnemxlRkRKSm5mOHlKbVZzSWNTNHowWGM1T0YxOVh2?=
 =?utf-8?B?Q1BrcjdWczhIZmVYZXJGR1YwL2xsd1gwMWVLWEQrUTkxcDM5aG8wSFhaS2pX?=
 =?utf-8?B?UzEweW5zZjh0Ni94TVozZEI3MVlHUy9yMWJlcjM3ZE51UmdubUNyOW5zSlBO?=
 =?utf-8?B?Q0tRQ24vWmJrQzRzWUhhUTJUQ0laVXVKL28rUE9hdERZV2JJS0hQMUR0a29C?=
 =?utf-8?B?TlVYTFNwdkczSlBTR09pQzFOYzJSN2IxYy9sbWhmSEtuRDdjb21WeTdXUXl5?=
 =?utf-8?B?Tkt2ZC9RS3FPM0oydDE0d1dVT3ByRmIvdm95eHFCYllMY3BmSUZJL1hETlBF?=
 =?utf-8?B?KzB3T2xjdE5hVXZJMWxBUlFJT0M0T05NVEN1azVjMHhtMkhnUVd5M3BVSUZk?=
 =?utf-8?B?M0s0ZUFnTnpwNWVpSnoyU1pKbVF1WFp3Vjg3MXE1ZEFDaHlwbEUydUZUY3dE?=
 =?utf-8?B?YzgxYzZEajMwRENsSWx6bEl6VTUxelN5c2M5MW1PbGZSalBqZFdXTmJ0M09U?=
 =?utf-8?B?SERZOEhmUXVTai9HZng0TGozZk1NNXNNK3BJa2Yxemd6TjZCQ2F2REN2bzN0?=
 =?utf-8?B?bC80bFdRNk82Ulp0bkpVMzBHeXNXS0NyRkQwaXB2SFlZcGZjQ3ZjNmFTTHNk?=
 =?utf-8?B?ak5SbHVRMXBWMzF2eFAzakpIMmwzYlBFYkJCcnNNck9VVTlwM09rZWJScTlj?=
 =?utf-8?B?Z2ZsZjk0emdGazh6OUEvbFRtV2RVeWpLQXFhMENIME51NElaL2lHNTJ4NVdv?=
 =?utf-8?B?Wk1mMVRRQnMvd2VxcmEvVzJRREtlSjZENkhCRkVRcjVScXJxU2swZVNKSVRz?=
 =?utf-8?B?cTlCZW1ZTC9qelYvbURHd0NmR3RFYnE2NW1VT3NJLzRDT0JTamNrcE9vT2s0?=
 =?utf-8?B?U1hRc1psMHZTcFlRWVhkWGVDZVRzYnM4S1FlVG15VnNpeElXN1RBMXFXRURY?=
 =?utf-8?B?U0xoWUN0TjNLSkNUekVBR09kOS84K1g3aldYK1ozdVR1SUJnenR4bVQrcE5z?=
 =?utf-8?B?UGFEaEtpK3Z5bjRaSGJybGxCSS9wUlVBSXlDSXA1RXBNenA2MWg5dTE4TWNa?=
 =?utf-8?B?VHRUODVHb1BvcllTUHpuNVdyZCtwU1l3Q2hvNDd2ME96U1BpOUcrenRPQ3Nk?=
 =?utf-8?B?Q3IrL0RNdm12QmtBYzFIdkhJa3ppa2VWanl4UUNBYWFCazZ5WXBpL3VXSGsy?=
 =?utf-8?B?NVA2cVZUd01aaVZNUUdlZGNCK0VZam1ycG95Tng0Z0JKdXBxNEQvRTZpdUNn?=
 =?utf-8?B?MnNWaXlMUDFteXBpWE9wVXhWRGdxdVVHUXg0bEZJOTNjWE5YZ2o5KzhZTFow?=
 =?utf-8?B?QXFBcUJtc21Fd3JpTTZVL1VuOXJqdFZVenVJSGlacVNzcWpqYjRHOWRXTlho?=
 =?utf-8?B?Z2ZiNEgweThjbE1sbitYYVArRUw2c3F6M2FpazV2eC9NUjExdTdGVEpQL3g0?=
 =?utf-8?B?cmdVNkR4L09HVERNSVdYWjdoYVFGNS9MekhIOWF1T0ZRTEowWDV5aVIrZndS?=
 =?utf-8?B?WkRDTFlzTW9jU3JQYm1JVkc5Q1kydThqRGZHcVJhdXVqWXdRWUExUUtyQXBO?=
 =?utf-8?B?K2dQYno5eE9aR1YyUGNZWVFGdkV4UVhVeHFJOWVMU1NucVNObWVsT0ZwaGR3?=
 =?utf-8?B?T1dPNmhXU09Vakp4RVdrL3h0c3M0T081b2xhOUdrWi9wTndUbHlIQUFZZkQ2?=
 =?utf-8?B?emVuMHJVZWp6VVRTUHJ5aWVJVUtXUmlETklZM2RxSTlaT2M3OXN2UXlvUXRz?=
 =?utf-8?B?U3l2OWZ5Vm1NTWpaYW5zWGxyTGJ1RnV2bHo0Y2VId2FVNGZHUDE4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ceb938-1c2e-4fb2-778b-08df43c2a41f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:18:56.8829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhK8GJ0LTRwi1gFXzqQ8eWK2iIZHlj1wOdEhU+quG1kVRUJWdRzXpE+HIOuvtNhbtlfJiIe7oiD0OZr+KrdinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/14/2026 4:24 AM, Hugo Sales via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+hugo.hsal.es@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Hugo Sales <hugo@hsal.es>
> 
> An upcoming patch commits panel_power_savings writes from the kernel
> without a modeset. amdgpu_dm_atomic_check() sets connectors_changed on the
> CRTC when the connector's ABM level changes, so that commit would fail
> with -EINVAL
> 
> The flag came in with commit c5892a102182 ("drm/amd/display: Fix dmesg
> warning from setting abm level"), which also added the CRTC to the commit.
> Setting the level alone left the CRTC out, so no stream update reached DC.
> Adding the CRTC is enough for that. Since commit b05e2c5e81f9

David Weber sent the same atomic check change in August [1]. Since his
came first, could you credit him in the commit message, for example
with a sentence and a Link: to his patch?

[1] https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/

Regards,
Chenyu

> ("drm/amd/display: Update ABM crtc state on non-modeset"),
> dm_update_crtc_state() copies the level from the connector to the CRTC
> state on the non-modeset path, and the commit tail sends a changed level
> as stream_update.abm_level. Neither needs the planes in the commit. The
> commit tail walks the connectors and takes the surfaces from the stream
> status in DC
> 
> This applies to every commit that changes the level. A compositor that
> sets the "adaptive backlight modulation" KMS property no longer gets a
> modeset either
> 
> The forced modeset also took the panel out of PSR or Panel Replay before
> the level reached DC. The non-modeset path relies on "drm/amd/display:
> Leave self-refresh before an ABM level update" for that, so it has to be
> applied first
> 
> Keep the flag for scaling changes, which move the stream's source and
> destination rectangles
> 
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> This needs "drm/amd/display: Leave self-refresh before an ABM level
> update" [1] applied first. Without it, a level change on the
> non-modeset path reaches DC while PSR or Panel Replay is active
> 
> [1] https://lore.kernel.org/r/20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es
> 
> Upstream, a level already reaches DC this way when a compositor commits
> the connector after a panel_power_savings write. The store has already
> written the level into the current connector state, so the old and new
> connector states match and atomic check doesn't ask for a modeset. Only
> the CRTC state, which still holds the old level, sees the change. With
> this series, the hardware tests in the cover letter apply every level this
> way
> 
> When a commit changes the level and also has planes on that CRTC, for
> example a compositor that sets the property and flips in the same
> commit, upstream sends the level to DC twice: from the connector loop in
> the commit tail and from amdgpu_dm_commit_planes(). The same already
> happens upstream after a panel_power_savings write, when the
> compositor's next commit has both the connector and planes. [1] sends it
> from the connector loop only
> 
> If a level change through the KMS property should still force a modeset,
> the store could flag its own commits instead. It would set a flag in
> dm_connector_state that atomic check reads to skip connectors_changed.
> duplicate_state wouldn't copy the flag, so it only lasts for that one
> commit. I think it's simpler to treat the change the same way whoever made
> it, but I can send that version
> 
> Scaling has been in the same check since commit 3c6d1aeb4342
> ("drm/amd/display: Fix set scaling doesn's work"). From my reading the
> non-modeset path handles it too, as a src/dst stream update, but it
> changes the scaler ratio and I can't tell whether DC needs the full
> validation for that. Could it go as well?
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dfbc384fbbdb4..256699cdd0b5c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6304,8 +6304,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
>                         goto fail;
>                 }
> 
> -               if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
> -                   dm_old_con_state->scaling != dm_new_con_state->scaling)
> +               if (dm_old_con_state->scaling != dm_new_con_state->scaling)
>                         new_crtc_state->connectors_changed = true;
>         }
> 
> 
> --
> 2.56.0
> 
> 

