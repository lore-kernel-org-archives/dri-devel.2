Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851F2C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67A910E5DA;
	Fri, 18 Sep 2026 15:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3EJVoeD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1CA10E5DA;
 Fri, 18 Sep 2026 15:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI/5jgM3/KKXUAgjUxG9h1glQgkqRJRZfcFuTaTXVuIfZX1zblsOOaWbQr3LdZ9u7AK7ZnLLZNLczuFchVd0bY7sc8TmG/bdoXDbcf3hfBMNLYWWwJbOqTzEThWBC11rEhV9nOnNREbIeqgfN7u6dmvQCkZcbpu3iLyrsEix4kfuNZ6JTw0G/ik5gxtoB1nZ43tUFnQR1vx9feJbPfafRToTV1mTcMapJ2SdXqHCF4aCKOntri0B7qQ2QzFqPHFEVaxfDyLT3VFwlwXX35knoVF5BplX5LYMmZt+UY+BfgCvh8prZcXDvBQL2IKvn+NiwTkbNXJbNzOwk8ufU5SeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufjt0kXKdNhGCOvOWg1No6utT2lxx+P+OrvEuS3wGco=;
 b=eylyG5jEyCqJHg1kPsKKX0Pzy2Ohvw49xXnhJm2SKuQ1qt9iJI0ustsKp8/obAbY1c+QFOi3nvuskwHoKaBP73joe75TyhGCiwS8akMK8bCYIvAYsV65M1IGOO4UxD0mOQkvbD3WYTbaPLev5Yt7mTLsLnA3jiFLo7N7PBldyOzVWdWPJ7KTx73vBnqMGkKsUV6Pl3fAcZcdMwq62tYx31HEdbZtY3yuvcA9CJLxsuyBtM70hlMf/YFDvuzlrekvKncDNRlG1ldGpeW24NbpEcRoc+TdOAfNH04vQjh14LJm/PPqbUeEzfizB7fpSQLuJaI9lTd0J+xLOoPBIj3tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufjt0kXKdNhGCOvOWg1No6utT2lxx+P+OrvEuS3wGco=;
 b=X3EJVoeDdrRsulqjzqVQiPBhGswA3qu3g/BnIe9+IuP1q1IpdV3kTFlhaDmgPDVH+Fr9L1NCp6jvmTn2LMGgEMwLceDZHe7e8Q0HOSohmPW+4PTJFmugAb5y61Z1UTUkwxk0yx0wIBQm+jhfgzM2y0fdXE8/ChfWGFVWtmcuG9w=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by CYYPR12MB8751.namprd12.prod.outlook.com
 (2603:10b6:930:ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 18 Sep
 2026 15:19:48 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:19:47 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, "timo.proemer04@gmail.com"
 <timo.proemer04@gmail.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
Thread-Topic: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
Thread-Index: AQHdHg+xXu4j1ejsO0mzSSrKwF/0TbbUuEIAgAANAqA=
Date: Fri, 18 Sep 2026 15:19:47 +0000
Message-ID: <CHXPR12MB9992209606BBEDEB43F0C0640BE5872@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-3-timo.proemer04@gmail.com>
 <20260713194945.2AFE11F00A3A@smtp.kernel.org>
 <20260727213305.810014-1-jerry.zuo@amd.com>
 <a8a004b82a037ec2f218d6b324298ba505286bc2@intel.com>
In-Reply-To: <a8a004b82a037ec2f218d6b324298ba505286bc2@intel.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-18T15:16:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|CYYPR12MB8751:EE_
x-ms-office365-filtering-correlation-id: 890f1d04-3f90-45be-53fa-08df15984685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|4143699003|22082099003|10067099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: uMBbuEXh4pzgW4ylCY8b68/l/YvNGQ9MtNl8fnvaRoa4OgrpYxveT6DAfX0rj0XcNCdfWjoLOLtu4+Hw2YuNaXXjdYlw89lXdTY9ffly9ApojqMBTAOhSYKqiF6Utn7lzhSJVqfHF+2O/dPJcXZ9g93WPJjVg37Zc8dPg1rzVVFzwQKh4FH6L/HidY9YikR5B1eb3eN2H/9Zftyih2tJ1a5FnDuy4zeI3Xmm7pNgDWvj3JuRlvWmpz+iQpeyo97hRsrlequwKjp0MZcCulTS5TZdT5mkj06mrh1WWjjILnR3RTQVyXX6Rr6JjMNIUCbGh9vMMjmSklqS5n1UPoidaA+AEWLIe6bm/klH24grzY/ZVvYz2IQSSwATyMgtCcjYSwx5OgrMVGgk1TfLaSH/vcUKGWqKnz20F0doLbovG+Xn4/x4b1SkVLUgKi8O74hRxG3dtUNPq2WbLwZvYE7g3hmeQZCkpAic/J08IyVTLe+/C05V9RT8fhb2wqvEuzhuHIUTKLIS1AbtnhKWwywv6qQTs+ZlhMPYdSivceqUUT3NcYo83TVjZ/Tfj6xhmbC18auA3XL0VZpNWuIME87Kc1iTSD78OPzWIrGxvGisogfL21g9J/NBf415W9ifHdVJHc0YRDqcs3nVL4umGtI2DZ7AQ8NoPsBJeHy5V9gC39ANqlSB8IwjRxxv3bNvsXoJHILR2W9HtldYqMrebeevKk14tPcSKSk7mnZSEAEkfqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(4143699003)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GTX3mLvNFkhbKXpmwGP/71DTxGlFEoY8kzZRrkmMJbZOh8+uJVooSq42TQeU?=
 =?us-ascii?Q?orVYgH38M0lKLxVO8f34xvm+Dsf30qpY9bQ6OmSd+zQKZPiVlVH1ExdGTCIj?=
 =?us-ascii?Q?nEnua5enK1fYu8t2d4vPRVIqkSNui6jp5oSuxuqe9VR+vOkquqowuVTUNi+E?=
 =?us-ascii?Q?u5K+YTcP0mEVQnTeYyq63bhlLdTxuOvG8ntlPaves3TM03SizIEGyKzcabVl?=
 =?us-ascii?Q?w75Zp5nSGGeCdYEUQTirv8op05FXhcYtTxdCpy21XCSDTejTONiAf9lbplYp?=
 =?us-ascii?Q?Btv1pECalgbKdF04lMTdfpMjIfByoWGkjdGbaLJAuse5p/UqaJH5PfFlt4xL?=
 =?us-ascii?Q?GXF6EVIlNG/W4hna4aZ1EQZAguNuJNnpbFbuw1WVWuY1TGGbjK+P0Hm8z/uT?=
 =?us-ascii?Q?mBa4xqnNm4CONHFxUgL+vD80S3B7XGoLRVht7DUmpYcBwO8FIsWCbMcrkDND?=
 =?us-ascii?Q?R27rqDSLwNOKP+cCAiIaDJvcLsVA3o3NGTtE8FQgNlFYhqfP/e+JtzrfIjLh?=
 =?us-ascii?Q?RPNwkl+UgEsQemOWpSZeTDedagZ8WuZ/L2xVMAZa2YnvoeyFdnPZ3oepoHFw?=
 =?us-ascii?Q?slttD7R+uL8lA6ixleiXIrJQXvDewz3yE/hmj0uU8V6YQa7R7+Op8ZQBHoKe?=
 =?us-ascii?Q?1dZ9o0QWkNHHYAl4R8ZA6tZRqvUBXxtIgciyrO8p9neHmdBbdALpRcySMLuY?=
 =?us-ascii?Q?s2Vh5nrhztGjazktvZsnUFb0hIAlmJe+CJSg1km7DShmLJAAYEsgpJEYAeYr?=
 =?us-ascii?Q?mvKim+CmMVZI/LPFPhliS7deoaB0Uc1rHlrfzQ8ZresyolvramZnq4/XAmzg?=
 =?us-ascii?Q?tZAI8Mdn1eXL6QQ4TQkNjgXPphjoOocNzcXevPDwiFraCFJUGTvCMKS3eiiZ?=
 =?us-ascii?Q?gZAR/kiGd/mcTYqU15AXr4Qe8pc9nLXBdC6psNE3qq1A7ywP5CEKEfWzAy0Q?=
 =?us-ascii?Q?Mlxp0b5JCPOucJ4IY7GGnaQqAlVs/rva+TBc8YFr9krFUlxAxG0x2LRylMaZ?=
 =?us-ascii?Q?bMClS3V/6vu3UF5cQgVwEbJUTTMcOD8Ge5ZCbg5VRbCjvnWIRZTjC2Nm3BJT?=
 =?us-ascii?Q?ceJB8y1snWF4nZ5pWQgQInMiZY+puwbO5uU7+r/kRBcZ+DuuznXpASmOUHCR?=
 =?us-ascii?Q?18dO/cU2s2hgrjQlvYAfIPKILdOi5FKBiADeY3B/EiaCnwjrvj4OqF0Wev/s?=
 =?us-ascii?Q?j6Eo60hCRKgOKHpYFHyyhJoHF+8KqfHofcnQJRkj3Py7Nv9Q1GIIhQYSJJs0?=
 =?us-ascii?Q?YzuQAWv3GwenCWTFVh32CFkeC5F+zJe0FQA+Hgi9QAbx2Hj2C7hP1vaYnXyZ?=
 =?us-ascii?Q?3E7RvF469h6U/RFpOJPZz7dGQxy6sSszSkJs/SOF/wEYD2GZJvzshpMJe3dY?=
 =?us-ascii?Q?T5oLU8P6YL7dKNJT5YAiPEilNP9JIT7sK+JjFKnHk8B5KIFwveatHYiFrvNT?=
 =?us-ascii?Q?85lfRrgDVQhAwsjC8d5V4SQUaUO2OysgREjQcP91HryjUkHEZbGVvtyQn6Ub?=
 =?us-ascii?Q?U4N4HzoBCEfDrF+NFUEiHR+Iqb7AwkyAGm/gHe1r7mxjidLY9QCDRhO9PvI7?=
 =?us-ascii?Q?FU8B95XquLyTg5KLgbDLikuCns05M4jQIiphr/FQanqp2zlwdA/zskQRl+fT?=
 =?us-ascii?Q?fZFKTcbdPLSp9tQWaEGzb+4HCu7jC8ijb+qsISaC1supbnPltW0+EcQlaORz?=
 =?us-ascii?Q?pv+ZVnV5duUyg9DtenrvZfRSl20QpPOPd74QkTAadYZGIfYQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890f1d04-3f90-45be-53fa-08df15984685
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:19:47.2129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqG+BeuJAlpFxahIHx3JAp5jei2NZklhCo5l5cLGaS90dJx7+RuFIS6N9Vk54KY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
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

AMD General

> -----Original Message-----
> From: Jani Nikula <jani.nikula@linux.intel.com>
> Sent: Friday, September 18, 2026 10:30
> To: Zuo, Jerry <Jerry.Zuo@amd.com>; timo.proemer04@gmail.com;
> Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Zuo, Jerry <Jerry.Zuo@amd.com>; dri-devel@lists.freedesktop.org; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
> instead of raw extensions
>
> On Mon, 27 Jul 2026, Fangzhi Zuo <jerry.zuo@amd.com> wrote:
> > Hi Timo,
> >
> > Thanks for the patch. Heads-up that this overlaps with a fix already
> > in
> > amd-staging-drm-next:
> >
> >   21590e1adc9e ("drm/amd/display: Fix 8K Mode Not Parsed by EDID")
>
> More precisely commit 11a90eaf5c80 ("drm/amd/display: Fix 8K Mode Not
> Parsed by EDID") upstream.
>
> > That commit addresses the same underlying problem your patch targets
> > --
> > edid->extensions (byte 0x7e) not accounting for HF-EEODB blocks, so
> > edid->only
> > 2 of 4 blocks of an HDMI 2.1 EDID get copied into sink->dc_edid and
> > the 8K modes in the DisplayID extension blocks are lost. It takes a
> > slightly different approach: instead of drm_edid_block_count(), it
> > populates edid_blob_ptr with a full, HF-EEODB-aware blob and copies
> > edid_blob_ptr->length. So on current amd-staging the
> > dm_helpers_read_local_edid() hunk here no longer applies cleanly.
>
> That's an awful, ugly hack. Please work to remove it. Drivers are not sup=
posed
> to look at or use connector->edid_blob_ptr at all. See the documentation.
>
> I really did put in a *lot* of effort into abstracting HF-EEODB properly =
and
> neatly for everyone, across the subsystem. The opaque struct drm_edid is =
the
> abstraction. Please embrace it, and you'll get HF-EEODB for free, with no
> hacks.
>
> If you face issues, please talk to me instead of hacking stuff and intent=
ionally
> working around the the abstractions.
>
> > Could you rebase on the latest amd-staging-drm-next and see what, if
> > anything, is still needed on top? There may still be value in the
> > helper conversion for readability, but we should avoid re-fixing the
> > same HF-EEODB issue two different ways.
>
> The one and only fix for HF-EEODB is to use struct drm_edid everywhere.
Thanks, I totally agree. The fact is the dc_edid to drm_edid transition/ref=
actor is not fully completed yet. That leads to w/a is coming up as a tempo=
rary fix. Will remove once the transition is complete.
>
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel
