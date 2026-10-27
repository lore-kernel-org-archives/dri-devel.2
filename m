Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A06606A336
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IwXasS8i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C24510F2B3;
	Tue, 27 Oct 2026 07:36:02 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC3A10E3EE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxg7ak0fDQtTwtml/m/87EBnCAqwvdZ+mgBwye2610eN47V/Mmq97OG/CXMTgJm5a4fWHgQp5LBBTxdbNeNOsxiu11ggQAw9pKBsGH0/8zbFW3jPkv4qX7NYOnmcNAkNrez5qKidAc2knEm7NUHJahUynH3Rnfu6ZbCnNiONXnRchc4IvhWlapZWJ4fuBwGi3Z8IIf0Up7tSl0qzcL9LVOHWoaQ5ynXUOeBU2rqql1mlziVTULj2gVXoOWVf3L2uIdeJrnyWl9Z7AJYQBpG7JpNz5x1aFewO23qkvZZsZVyk5NzKX60xephIgcwCcRbW0pWt9dqU1tNN9D5KDeTddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDRHymdnPy7J8Fik30phCuym/L6L0WD0SCbg0H4C+Hs=;
 b=bcAtMJqbTm44UMq9RJyl8K6V0NqqO+V7xCTqNPAgH1TUBknYzY1Gj6b61bQoL2tAw0YSCFv3C4fvSVHKQx3C+Xf6T3TOSyg1XNxwe8Nq+L1tb9B1FeBS+6OtnCy1KE8e1/WMDTCoCr8TpRwkJKji0KhtDk1E0cEiMSBpp/doLAR5m7RXz32sM4uMkCivNiJzOcXkqhdDAV2NML2zc5rUdzVWxb+JmkkcXIy3PUJLc3hmq4kDqt0iYT7LZumIBelbub8LIXzhPwaOQLMh2P6L3NC2VCMz5cngm0/dcbkBeQb2vN7xrDUFA4L1D9OrL17+C2Df+/u4na2TCpvgGsIlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDRHymdnPy7J8Fik30phCuym/L6L0WD0SCbg0H4C+Hs=;
 b=IwXasS8iRLI1IEzp/1D519dlfqWZzYKmztpAVXSfRc553t+uLwM9U36rLFFbiEAcqEMnommuEm3UInLLreAKOivBH9AkipAwlWJ4FQp8Tc8M1qOvfY9YAE3twDPpxdIxatgurLYPU+fR3qkGquXlucLwV++MLBHUAn0NV18w6a2Uvv2qBh9whYv9lvpaarBQvfLzQdfKvvHvfs7CFEZxc+e1tK8ny9pbi8/gwnx3UnvJXllRaqmQ7Hu7SYeJhTcIck+5nb8HSgm6wSl2S73t8/aqVkykmF4wJSH+TYJTFhuycM/zBStX23AxRITZEi5TDlus79d2lGoy8AehEJhJWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:35:50 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:35:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v6 00/15] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
Date: Tue, 27 Oct 2026 16:35:43 +0900
Message-Id: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzU7EIBQF4FeZsBZzuRTauvI9jAt+Lg4m044wE
 s2k7y6MicFUlyc53zlXlilFyuzhcGWJSsxxXWrQdwfmjmZ5IR59zQwBNcw4cnfybzydHSevwqT
 AIozEav2cKMSP29TT83fO7/aV3KX51jjGfFnT5+2riNb7Y7YIDnxC9FaZMAugx6VEH829W0+s7
 Rb8T2KVTgatDY3S0rCTspMSOimrnIUWMoBWCHYnhx8pAOZODu1zNnbyJLwMuJOqk9h/qiq9I7J
 TkBrI/ZLbtn0BAdG1JZsBAAA=
X-Change-ID: 20260927-cmdq-rpc-ed5f850b207e
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0255.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b677d9b-d6aa-48f1-abf0-08df33fceb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: tU1lT5VbDblwuBhR0o2Xl8k/WdPMjkwQdHuoX8oTcGUpFLndUmZV3VuqpqGm51s1ArPirvbNoWsj01JPsE6qq6tyQjCQvPK3cX0aidFacXlLhux+cV1myntuwXb2lLRfNc1PPKmTlJBZGw1253sBVxe3LENr0uyqIPBfJljewRPUR8GwknOXL0VhJx4QUEMiynKQBru7A2p0KlOOONdIUajkAYgl/aMXUyg2ECW10XWUaVqYyGdn8Nhc9GvJGLcV3QIrWS76kDEuENj0Rcy99kVZvsvXKcV72tFy+qDHqvWWO0NRsOnLtDP3xC3o4YIX2Ue0gIj+SChPffu3kouoH0flA0g1oomSkFH3BAyFPbw8SwMnaEewvmqeSBE2O/u6O2mYxOS+NaHFKRsR1XvxVl2zEPDAERhlHzeCYkChQbOhb2bkd9O/gRj/DY2kuYgXXWwa3ULJYU2FhH9xwIdyCAAfKGq3XfyM60Vuwzv3pldE8e5KYlN4nhpIAsF9/HGwYK/CMFT6iH4n6kDvQ5F3AWlSIJlnBbAORKtmfrvwseyyoZ5MGQ9swXU/iDRN4f1+A9MmR3yrdQlrpY42TGw0TJM9TA7MX/3hjpFE9zYHWL77BHE6JHHjX3ycSFBKhoZSAZZ6ndvDQ+14kwzuEpeLUQIrCww2bD7AvOvMfXk2PPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9iVXpFTWxKRjdDMlNueFBseDk2eUQ1STNWbFNYdFFPVzlNRW5mbFVlMzha?=
 =?utf-8?B?M0FHY1VLQ0Z6N3duWGMyc0pnVmtUcDdxRjM1N1pYWTU3bmFTZFNYRGFsN0Rt?=
 =?utf-8?B?VmJnUTFXdnFpREdMY1U1Y3BaWUkvNVhqZXJMRlhEUnRiUzJ4MXVDcFBWZ0tL?=
 =?utf-8?B?UzZTRVU0eVZkcVhMSlJNdE1uSld3anJGZ3RlNy84Qno1elNPRGtjUTB3QUlm?=
 =?utf-8?B?NXRVZ2d2MWlCK0g1OEIzMW9ERTQ1cnJEbVRvQWVQTGt2Qmd0NWRtWENvcHpM?=
 =?utf-8?B?TlBUTVI2OWsrRjA2RzFhTXdMZllCVG1OOEJaNzFHenJTREFFZXBTbWtmOGtw?=
 =?utf-8?B?ZWhKQ1hvWWpiVzgxdW16NjdlcUhWOFNPS2xEKzRWQjRyVU5UclVBa056eS92?=
 =?utf-8?B?d2tlcWUxTGoxMStHaHluTUFSTXNkTW5Qa0M1RTZEVyt0aGM3OHk1dHF1VWFo?=
 =?utf-8?B?VzdpVHBxU09ZM1dZTGpRYlpzMnRHU2R3WW5haU1zRDhUdUQyRTBJeXVNYzh6?=
 =?utf-8?B?UW0xVVRZTThlOVZYdk5TSUJDb1RtSlp5SGZrRlJvTTlFWHVFZkxYTk5rMWxs?=
 =?utf-8?B?TW0xdnBEZ0tqeEIwbmxuR1BuWExaQUdHL21qSzVvK2xiZDZ4SmgrSDh2K0dB?=
 =?utf-8?B?N2dIZUJtcEZxWmhRbytaTmhpbE5wbXlOYTBRMUVNbnRvTk1DWERLSE5jQnN4?=
 =?utf-8?B?TEZXZlhPTTcvNElVMm14SmVqcG1MZEpaNzVwVEtXbEwxVEhMZVR4QXlvazZR?=
 =?utf-8?B?dlpGdjh4RnVsd2EyblNpanVwMi8wL2tLb0hVYW5VQjJJSGNoaXluS2tmQnhq?=
 =?utf-8?B?aThleFpiNHRZRk5lZTAycFRIMGw3MjJRamNoSytNZ1FVK255cm9QSU5Gb3pE?=
 =?utf-8?B?aTBFUVdCWVUvUFhqM09vaTYxU20xSitLai96UnhoYXJhUVB5RG9KSnlNWTRC?=
 =?utf-8?B?Z0FkRW9uMC9MWC9GUVEyTUU5dnQzdEJRTFRVUUthTmVTWUlwQ3h4RHFHbC8v?=
 =?utf-8?B?S3kwQ2JCa3RqZFMyb0o5bDFPdVh0MEhQK1NPbU5kU1RlcEZVK0dxclJEYkxV?=
 =?utf-8?B?bmswZVcyMG4zQ1dxY3NhS1RUUGNSaHMwVlVRSXZHbDBGdWpGUHlGRVpSSFJz?=
 =?utf-8?B?anJKRm5RVkdlZkpTZUwySUJkSEI0enJUS3d5TTdaa29waE9jUlRzSnBsNFJI?=
 =?utf-8?B?WnNwaG9GZEovdDY0Z3hGWVJvTmh2b2dDbUt4VWQ2bXFNRW1OUjRCUVBlUHlL?=
 =?utf-8?B?TCtyRHVUWFhTMERKeDNSaEhORVo0MHVHMHpyZ1pPaXFXZncwWnA1VWgrU0xD?=
 =?utf-8?B?b3ZtL3Z5d3JYcE0vbEVyK3B4UVc2MEE1eWkybVNqMmZvdE51cjk5bWJFY2Mv?=
 =?utf-8?B?TWpQcmVsVC9VajRvbUlJeVo3bElMUnd6MHN4RC9LRWtidExLTUJoOGx2d2N3?=
 =?utf-8?B?dG9aSCtJRE1sS2RhME5NajdVVzJPU08zWmh6SW9PWWM2TWZNR3dlbU11SXdS?=
 =?utf-8?B?bWRUMFhkS3I1TnVjN3lsL3dTK2oxQ21LejdQajhuRGhNYXJaN2Q0dVk0U2ww?=
 =?utf-8?B?TFFrYndJamNoYjdVN0Rrc2t0NGdtb0t5QWkwUkZOUlFnb0ZkYTZFNG9ScFJD?=
 =?utf-8?B?dHRwSU16dkR3YmFQQnEwdWRkZWFhVjlUd0FjZjdWaGlFL3FLdnNNMXQ4c0Yr?=
 =?utf-8?B?Y3haeFhNUUlYYmF6TEs1TmtlanNpeE1UeGgvL3Jmd0diSllIOVFxbmNFUWt5?=
 =?utf-8?B?YXVCaU5WNERHcE5qbDMzWU0xZTJrdEthQ3lCaGkwQ0xpUC9GL20yYTh1RS85?=
 =?utf-8?B?dDdSeVFXVGtvSGJ0MnNsUXJEcjROWi8wZkdzTytjL1NLOVJ6M2gyRHBCNVdQ?=
 =?utf-8?B?MUY4Uzh2SzFwTXZqTnROZ2tETzhPZDdvY0wzYzR0ZFV5YTRoWC83dGVRdnR1?=
 =?utf-8?B?LzhWUXBNNEY1Rld6YnV2SzNaWU1hUFlvOFM3RUp0S0dQN2V6NGNVU1Rhcncy?=
 =?utf-8?B?TlpUSE10aUpMb2o1UVpmVVJzV0JmZ01pZWh1WnBYbHgyWmQ5ZE4rUituT01Y?=
 =?utf-8?B?ZG9KL3VBeW9aYmZ6TDdUa2FZNGJSUWgyb3ZGN1VyTlBKWkR2a2lnTEI4anBC?=
 =?utf-8?B?RWdxOEdaZmRrNHRnTVM3QmtLd29UTzg4Y1VYbnVZSktMM2VkdTA3S1BoaWtB?=
 =?utf-8?B?bkdzcWhIaEE1a080WkprU3JhcENQdjFPTm9xaG5BZXdKM1NNM0dTeXhLVjJ5?=
 =?utf-8?B?SEl0Nk8wUysycTVnMU51bWJCeGFnaXdhU2VWZ1VKSndBdUE4N04rUTBIcHpW?=
 =?utf-8?B?b0JGL2MvZFZubVIvaW9lbjFMRHNPZGhGbkJtbFFLbkNKamdGRytvbStWYmln?=
 =?utf-8?Q?MwHVf9PIdE20T46Fb3hj6aX6QlYXGPWLd60q88dlc2LJu?=
X-MS-Exchange-AntiSpam-MessageData-1: FjE5CCoFCuEpTQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b677d9b-d6aa-48f1-abf0-08df33fceb9a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:35:48.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e60b46CEbaUHadoPnKp7wZYw1jDA8vjyLeEcY7YY8i+nVgOlLU5MBnVONMKdbUrNj9a67CtwYTcy8yZxGye3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The upcoming r000 firmware support [1] introduces a new type of command
named GMC alongside the existing and already supported RPC command type.

Since RPC was the only command type supported so far, it was embedded
into the lowest command queue level: the message header actually
includes the RPC header and the code considers them as one.

This makes the r000/GMC support difficult to land without a refactor,
with the result of transport layer code being duplicated between the two
message types, and no clear separation between the RPC and GMC code
which are mixed together in the command queue. Merging the code that way
would introduce quite some technical debt.

Thus, this series prepares a proper landing ground for a new message
type by extracting all the RPC layer code and moving it into its own
sub-modules, making the `cmdq` module completely agnostic of the type of
message it transports.

With the transport and message layers properly separated, support for
GMC can be added into sibling modules of `rpc`, and the transport layer
can be converted once when doing the switch to r000.

This moves quite a bit of code around, but most of it is moved verbatim.
No significant functional change is intended.

For the r000 series, this essentially means the following:

- Its patch 7 making `allocate_command` generic can be dropped as the
  transport layer makes no assumption about the message type.
- Patches adding GMC support will do it in dedicated `gmc` sub-modules,
  following the model set by RPC. These `gmc` sub-modules will start as
  `dead_code` as they are being built.
- The "switch to r000" patch will essentially operate on the transport
  layer level, i.e. `cmdq.rs`.
- There should be no need for extra post-switch RPC fixing, as the
  transport layer code will already be shared with GMC.

Overall, this should make the r000 series much easier to review and
eventually land, while not creating new technical debt.

This revision fixes the latest nits while addressing a couple more
issues found by Sashiko.

This series is based on `drm-rust-next`.

[1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v6:
- Add comment to `consume_element`'s documentation to disambiguate it.
  (Eliot)
- Add a patch to avoid sleeping in `drain` when reaching the end of the
  queue. (Sashiko)
- Fix badly-formatted import block. (Sashiko)
- Link to v5: https://patch.msgid.link/20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com

Changes in v5:
- Drop `MessageElement` and instead use a closure to process messages in
  `consume_element`. This reduces the behavioral change of `await_msg`
  and harmonizes it with the behavior of `drain` to the point where the
  latter can also use `consume_element`. Eliot's R-b has
  been dropped on that patch as the code has changed significantly.
- Avoid unneeded temporary result variable. (Eliot)
- Rename `await_msg` to `await_rpc_msg`. (Eliot)
- Add patch splitting looping behavior of `await_msg` from its RPC
  message handling.
- Add patch factoring out `drain` code.
- Add two doccomment fixes.
- Link to v4: https://patch.msgid.link/20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com

Changes in v4:
- Rebase on top of latest drm-rust-next, including the interrupt series.
- Move RPC parsing code to `RpcMessage`. (Eliot)
- Do not mention the command queue slots in the public documentation. (Eliot)
- Use different names for the length methods of the message and RPC
  headers. (Eliot)
- Fix bug where the RPC header length was used instead of the message
  one to compute the number of pages to advance by. (Eliot)
- Add a patch moving the message logging code to `RpcMessage`.
- Make the `rpc` module only visible from `gsp`. (Eliot)
- Link to v3: https://patch.msgid.link/20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com

Changes in v3:
- Use dedicated `RpcMessage` type to distinguish parsed RPC message from
  the transport-level `GspMessage`.
- Introduce traits for sending and receiving elements on the command
  queue (thanks Eliot!).
- Split unsafe blocks, drop unused impls, and other fixes on patch 2.
  (thanks Eliot!)
- Squash the two move commits into a single one.
- Link to v2: https://patch.msgid.link/20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com

Changes in v2:
- Fix checksum on receive incorrectly using the whole slots allocated
  to the message instead of its actual length. (Sashiko)
- Drop patch 1 to avoid having to validate the `elemCount` header
  member against edge cases. (Sashiko)
- Fix incorrect layer separation in receive path, where the CPU read
  pointer was advanced in the message layer.
- Move `log_event` into a method of `RpcMessage`.
- Make the `rpc` module only visible to `gsp` and its submodules.
- Fix doclinks pointing to old function names. (Sashiko)
- Link to v1: https://patch.msgid.link/20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com

---
Alexandre Courbot (15):
      gpu: nova-core: gsp: cmdq: remove stale comment
      gpu: nova-core: gsp: cmdq: simplify framing error description
      gpu: nova-core: gsp: cmdq: validate checksum earlier on receive
      gpu: nova-core: gsp: introduce and use proper RpcMessageHeader type
      gpu: nova-core: gsp: cmdq: group the RPC-specific part of send_single_command
      gpu: nova-core: gsp: cmdq: split the transport part of the send path
      gpu: nova-core: gsp: cmdq: split RPC parsing part of the receive path
      gpu: nova-core: gsp: cmdq: move RPC message logging to RpcMessage
      gpu: nova-core: gsp: cmdq: split the transport part of the receive path
      gpu: nova-core: gsp: cmdq: extract await_msg_with from await_msg
      gpu: nova-core: gsp: cmdq: do not sleep when waiting for a message with timeout 0
      gpu: nova-core: gsp: cmdq: use consume_element to implement drain
      gpu: nova-core: gsp: cmdq: move the RPC code into a sub-module
      gpu: nova-core: gsp: move the RPC commands into a sub-module
      gpu: nova-core: gsp: add `rpc` to RPC message send/receive methods

 Documentation/gpu/nova/core/interrupts.rst         |   7 +-
 drivers/gpu/nova-core/api.rs                       |   2 +-
 drivers/gpu/nova-core/gpu.rs                       |   2 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  12 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 486 +++++----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 415 ++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              | 329 +-------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs          | 333 ++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                    | 123 +++---
 drivers/gpu/nova-core/gsp/sequencer.rs             |   6 +-
 12 files changed, 947 insertions(+), 772 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20260927-cmdq-rpc-ed5f850b207e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

