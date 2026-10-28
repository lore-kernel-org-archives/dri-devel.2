Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FKHAZOFZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0F510FC03;
	Wed, 28 Oct 2026 12:28:44 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6F910FBE8
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 12:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eodD6+PfSxQhdUvoSeQ+U2IIBxDrLE8ylS5b4618b/A/0DfVXZgCpfFAsoJl9FXGhlpOZkflOfDSc8vwNbempQDXggp+ua8X3faNM46ccjgzFhd2e+3qND7UCvt5eSNfGeFXZhTVwSYGGL6iEvt81pPpVX2kAiWLY98WYKIVuJAHkQXjuhpa44H+ZIXaPoKIfJMuasahz5MhV8wAYJ81WB7bLAMB2V+fi9cIA+lIS6yXOyz/EDRFw10gG06WYL1ITJB9ZuCGDMkk8DCQLIXcPjXaGLkAcqXe6LXkobezauWS6J3F26K/7fcdWNSSzFyfsGVYctBV4vtSl3sqa6lPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECxB1aQT1B9AaFeds2rQI5oKocTJuBjNQhzyeSNJZYY=;
 b=jCNIlIh1f/1xGgmVO4qkuVoxz0QTFxl/fAj6snGpYy/Y3KlP4YQa97r2RoJ2QV/s9z/MjSlqCMFH7WgdAdjzoF1G1CioHWI0S4jx01beVd8hPyGjuDJuczF2+yOj0nJVVoHRmi59WNcTjYoa3vLDcF5wmIw85G/21VnXXP1yItyyG0Vpaczg5IypMWvvHfdCoxjJyIha6/+WvPxd37OoZV6HaYbGGpJAobHjqfQJtREtGe5C7kvcQtMgLHjAfAiIS52XglM02u80rmQR4qTAiRRyXXuI7g2i1LOdz6FShgZryf7lTyhILhA/A7njXNaRm9dWnDtY3MsHledgWehDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECxB1aQT1B9AaFeds2rQI5oKocTJuBjNQhzyeSNJZYY=;
 b=FKHAZOFZr+2Li3eTPToApWAULVoSXGKzEUXmcZds5WJK0Ov266kMVututD+Vd7/aj3uPMDljX9UrUiO/jdTRkQUmnVQs/ZfYzEwoq/yap3cMMSehi2Tsm/Z7KZO+6XJJx0r2OZg4kr61eAHYHsBLwGYDbXa73VBFkw0/KJSrb6me6swxR4+eQd3de6CiAlYOpzpfZmyaKeqJIlIEI1nG1Kt1ROD2DXCh3FdRTUH7hjBEM08vcYfxc2yFWrRwP6oqJ9SxLvdJw3S/FnLNhagoVhBwAftS8hKSrhR8XoYznto6hQBhO3/djTwgGeJnPpGiSpfLQD40FLIMp1DQR5aeSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 12:28:31 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:28:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 21:28:28 +0900
Message-Id: <DMGGZF1N5CM8.38XZQHRGOG7UE@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v6 00/15] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
 <c9e88fe3-24da-48bf-8a84-1afe22949021@nvidia.com>
In-Reply-To: <c9e88fe3-24da-48bf-8a84-1afe22949021@nvidia.com>
X-ClientProxiedBy: TY6P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::11) To PH7PR12MB6858.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: f52a1950-f6ca-473d-9388-08df34eef9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|10070799003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|261022075727099003|261022105027099003|261026121527099003|261021135927099003|261021123027099003|261026140227099003|261009223027099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: l+V31xgMzZDxNCXh6Pv0yrTI5tzsTd1ZuhVdFsa9uL/TK+6BH2csq4cZqAtLordpJN9PT0ohvv7zj/9RNrxAqK+bo/bzn4AP5c5vI9W3/zNbJOiobxLJ3AKH4m+pIBT8vl7HqDznGhwZF9uKv9AhrzYw2jbuFcq2ZOqRbBDSBMK7wm+6/4LarhYUjXQxWs5WbgL56v1uysiiRgOTrviJoj/bnWpkdv+LmDkASBdU4gcv0GXyzT8h5F/AyhYpGSariZqkg00T+s5BoyNgRWfJbz6BmRo317zJdUVn+cL8PZ5Ob8cnZiGMdL3veGK1S9eifAS7eDhOurbwgOabf4Mhhrbbyn04hAxHj1diJNEHbgdcMX7j0cIkW65FXEW8SwZ0CsUNknAaFb9KmKlfZsffvqC7dbErLcD2sRKiA9XmGaWVEu3aELGAtaXYquV9LMqUoSdLQAqaxgH2QiGYfL6sA5O/FVGtLk4pWbs3OUpGm8TbOwLgiPsGrU5pB1Jbe8lmvBL4+eeaFeKw3nhFz5M0Rk7pPaB2y1O2P1BcO98x+VcSExjutmVQHfQEsC9arB4pxcXC6R4Nfg4xbj5TESkfMjtwJxP1+hkTfwOw1ydzZR4yPPWe0Q0N6N2tV2gaWsUzqNgn4wtiKcy+irChkkJ4YUiani9osc6y9HtjAV20zSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(10070799003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026121527099003)(261021135927099003)(261021123027099003)(261026140227099003)(261009223027099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVgxc0tKMm1Jc3hEam9oQ2E3aS9kVVNHY3JHNVVQdWVTNmUxb0JyL2pYMmx2?=
 =?utf-8?B?cW12bGk4Tis0alR5ZjdNZXJ3RHY4VzlLUnp4bTRrdjU3bDdlUWFCNlJ1R2dy?=
 =?utf-8?B?TlQvV2NvRkJsU2w4VHc1SDhxZ1E1TFVuQ0hyeFdoRkNEMzBpVUdOZHFycktm?=
 =?utf-8?B?bTZwd3kyakJXYVkySmw3STY1TWRzdVlSVmhSRkd2cEVzY09nbUgrNUlYTG5D?=
 =?utf-8?B?MFM3N1ZPWHJxcE0vVWxhY1pQZDgxQmt1Wk5JWlFWV0kzOHFqcFc1Q1dQYXNW?=
 =?utf-8?B?dkM4ZXNsNmtlV2tqeHpUTFJBeEFXYzQrL2h3OWxFUU41SVk1NHNhRE9QV2RO?=
 =?utf-8?B?Ymg2UlJFazVtZ1ovQjVKMHNlOGN5ZjluTWpoOWpuK1JYZlN3UUg0eS9PcEU0?=
 =?utf-8?B?dk1UMXBiL3U3UW5xTEhqdHNmNEFZOXpVODFlUWZaVjVtR1cvQjRhand1OFRH?=
 =?utf-8?B?MjBGdUFIS2JxVldYSkJEMkRrMXpaZGRzQ3l6ZzRpK2JrQ2VPSy84QUFkKzNq?=
 =?utf-8?B?Nnk0ZDhaYldNL2sweTMwSGkxUStnL1lXTG91YjAzZWdCK0ViT2RUWWpwbThU?=
 =?utf-8?B?RTJUKzhNUlJaMnk0ckgwZ1VKRklRWHAxeXVjSGwyUmNWWWJNN3d6YlFhK2RS?=
 =?utf-8?B?YUUxVGRMMklDZGk2cms4UC95a0xwLzR4QmpUbVhoY1FPQkZheWl0WmFkTE9y?=
 =?utf-8?B?eFk0R1NUemZvWGVRVDRJcVVIYy96ZXJJWU5NM2l0aUNXQ3U4NVJDU2xRTzBw?=
 =?utf-8?B?cnAvOTZrZytpajZrTndyMjBybVhVMzRVZCtSRXU4cDVJd1B6bHlMOHJXbVFu?=
 =?utf-8?B?cGNNdElpTkttSlIxbTJ5b0Fod09OWm53cmZYZWo0ajhrZnR3WWhreGtCUWtX?=
 =?utf-8?B?d2FJSTdRVUhyRTBkdGZnTGFCRnIyRzVhR3ZJeStKSTRRcHRzcDc1R2w2MW5P?=
 =?utf-8?B?OTIzNzdiV3dPWWVqSEkrbWdMY3h1NDkyTHgybHdBMVpKeGRCZGQzeU5jMFVZ?=
 =?utf-8?B?T2dueHRpVEwyY2FiVmZxbmFEWm5oY3FDdzBKU3Q0VXM0UlRnc2NNU2RIVTRC?=
 =?utf-8?B?Sm54TzBiL1dNNlN1V01EeWNIeGtrTGRLbWRWbkNWdmc0TG94c3cxSTBwdEgy?=
 =?utf-8?B?NStqODZaSzBBd3FYVWIvemVLcUVhL0UzWkpRT0pzZ0NyNWg3Q2ZGSi9IUG54?=
 =?utf-8?B?MGdDejRQMks3cE05VGxWZTQ1a3pyYWtwT0FLSE1LT1k0S1pMMHRjT05QOG5B?=
 =?utf-8?B?YkJyUzhrVGc4MFpYYVRNN2piMmxFRmlZZ2VqWDBRSTdpeWQwNWtUNjJIbTIr?=
 =?utf-8?B?d0Y0eTgxTkpod1lXM3NHYzFiZHFmcnRYS0RDeG04UVhKT2FvK3ExWm1OeENG?=
 =?utf-8?B?dEZwa0NMZGV6TTZFMDRKM0oya3RkY1pGcFhMRkRtSkpMZkxSb0dxZTRhZWh1?=
 =?utf-8?B?Znh3R1FxdExQZWNNOW9xYVpURUJ0WWFiNksvTXVYb283YXd4MTFvTzIxKzhl?=
 =?utf-8?B?cjkzdkZ5Q015amQrQ1BJUUVDUW1zYlRmVjBEUXR3ck91T3FzbGc1VThTU0VM?=
 =?utf-8?B?cEY2bmpta2xyWUtNZi9wT2owb0V2STF1RW9rNGoxOE5UYXNLemlsd0xpS25p?=
 =?utf-8?B?TVdGbE5qMDZrdnRCbXJ0Zkw2M1Zkc1VVMnAzTmx5ZzB4S1N6Z1FUUm16ektJ?=
 =?utf-8?B?UWVqdjFOcW1ubjRDMTF6cGNJcy9OaXo1OVpZcmY0VU5QaTBWRkU3R295aHlj?=
 =?utf-8?B?RGpUWGNZb3hhTEpCMXNGNEhxVU9kcWVuZlMzM2hVb1FJbUNkVU91S0hvbDBw?=
 =?utf-8?B?TXJIMUhiZkZsSkxOaGVvSGh5QmNiNk9KdTJHMzFxVGc2RmREVmpjc1BMWjdI?=
 =?utf-8?B?Q2d6aHV2bmZCMi9tL3dwM0tIMVpIaFZaWk9iNzhsY3craGgyQUszYVZXYUdW?=
 =?utf-8?B?NFJqbzdTb2JBa0RnYWcyamE2TVBwYTZVMHZQVi90TzQzQXhpWm1VbU4ySFhx?=
 =?utf-8?B?cWxUS01JdnBON1h0YU5VYXZCeXloSHlhZEtteXVvdHF1SG1EMHdGNEhGYjE5?=
 =?utf-8?B?bldpdWpzcTFRWGJ0VXJXVk1JM0pMWWxLR3M1S1poVklEOEdPT0NUWXBjTGl6?=
 =?utf-8?B?UXcyU0dPWTVMMkFoY3N3L2lsRHhCemhNL0tJbi9IV1JYWU5FcjdFUDdacXdu?=
 =?utf-8?B?a3J4TkJGRW1tMXlpMWpidHJUU29ZS2k5MWp0QWRFZXk5aTVTVzNKcW02b0Ro?=
 =?utf-8?B?eEZ1ZnRjMStUZnJ2NWliaGlzMkpNeEpaNEtyOFBIWXZPMktKRXRMcStnYXB2?=
 =?utf-8?B?bjJkRElyZ3d6ZjEwK3JDMlRhWG1Gb01rQ2E1WXN2NVJIdXdhUXp1L2lXUWlB?=
 =?utf-8?Q?ZveLQcqxcj9RvdKo+RILTpo3B30JmcG8D+zKDbqelxLmU?=
X-MS-Exchange-AntiSpam-MessageData-1: eGtN/F6dt5gUIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52a1950-f6ca-473d-9388-08df34eef9ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:28:31.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXQSe2slttqOmVFT3v+DK6VR0XzU61U4oeFx+z6aLXAUVBDeuuqsES3OS869Z9GnNDhX4lrMLwGf3wjqO4suaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

On Wed Oct 28, 2026 at 11:31 AM JST, John Hubbard wrote:
> On 10/27/26 12:35 AM, Alexandre Courbot wrote:
>> The upcoming r000 firmware support [1] introduces a new type of command
>> named GMC alongside the existing and already supported RPC command type.
>>=20
>> Since RPC was the only command type supported so far, it was embedded
>> into the lowest command queue level: the message header actually
>> includes the RPC header and the code considers them as one.
>>=20
>> This makes the r000/GMC support difficult to land without a refactor,
>> with the result of transport layer code being duplicated between the two
>> message types, and no clear separation between the RPC and GMC code
>> which are mixed together in the command queue. Merging the code that way
>> would introduce quite some technical debt.
>>=20
>> Thus, this series prepares a proper landing ground for a new message
>> type by extracting all the RPC layer code and moving it into its own
>> sub-modules, making the `cmdq` module completely agnostic of the type of
>> message it transports.
>>=20
>> With the transport and message layers properly separated, support for
>> GMC can be added into sibling modules of `rpc`, and the transport layer
>> can be converted once when doing the switch to r000.
>>=20
>> This moves quite a bit of code around, but most of it is moved verbatim.
>> No significant functional change is intended.
>>=20
>> For the r000 series, this essentially means the following:
>>=20
>> - Its patch 7 making `allocate_command` generic can be dropped as the
>>   transport layer makes no assumption about the message type.
>> - Patches adding GMC support will do it in dedicated `gmc` sub-modules,
>>   following the model set by RPC. These `gmc` sub-modules will start as
>>   `dead_code` as they are being built.
>> - The "switch to r000" patch will essentially operate on the transport
>>   layer level, i.e. `cmdq.rs`.
>> - There should be no need for extra post-switch RPC fixing, as the
>>   transport layer code will already be shared with GMC.
>>=20
>> Overall, this should make the r000 series much easier to review and
>> eventually land, while not creating new technical debt.
>>=20
>> This revision fixes the latest nits while addressing a couple more
>> issues found by Sashiko.
>>=20
>> This series is based on `drm-rust-next`.
>>=20
>> [1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia=
.com/
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> Changes in v6:
>> - Add comment to `consume_element`'s documentation to disambiguate it.
>>   (Eliot)
>> - Add a patch to avoid sleeping in `drain` when reaching the end of the
>>   queue. (Sashiko)
>> - Fix badly-formatted import block. (Sashiko)
>> - Link to v5: https://patch.msgid.link/20261020-cmdq-rpc-v5-0-dceeb8f360=
ec@nvidia.com
>
> Hi Alex, looks like it is converging, are you planning to merge soon?
> Or do you need more reviewers to weigh in?

I was planning to give this (hopefully final) a couple days on the list
to check that the r000 rebase on it is viable (which it seems to be!),
so unless someone screams I will merge it very soon.
