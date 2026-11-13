Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF07606A330
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMJqI2ZJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=G1qOsuhU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA7F10EC89;
	Fri, 13 Nov 2026 20:11:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD9710E826;
 Fri, 13 Nov 2026 20:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794600650; x=1826136650;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SaqfXnO8TlZTwIK/efdZcWYYqbdX9XnvrxKxJis749k=;
 b=EMJqI2ZJeppA5n8ZwmcoV4qjs2H7OV7skUVvgQrerSP4NPMRC60sO8vw
 kRG3MAqxax9usRbrMo5/I7S4q0JAW3jjPl9i55oUBuisC7P0319rJO7RL
 P5b6YI7zlRNCxZ6eJ1OkaZuOkmZiKZ+SRF/soBD+oWD8Lb2s1uMJhgLbZ
 uKUux06WQ9gFsncPsNCteg8P2EC6M6k1ohWOnHlRGF5gb/wVV0BkkbCmC
 mzsmTGQS0yIFBexrdMnlBpwGa0IizLbfbmFrzeVW1X/u1m0OMFSJyTE9W
 Qud3hEB3rxB6uuSmvgRKqKy9U8IjQShh/J6XRntjMX8WPxiJItDVe5XZa A==;
X-CSE-ConnectionGUID: fmUQvO63Ryuc/Cp5JDflhg==
X-CSE-MsgGUID: qpfVWJapT/2f35HUi8nbrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3445997"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3445997"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:10:49 -0800
X-CSE-ConnectionGUID: HhE89YG2SPSfizxvkT45tw==
X-CSE-MsgGUID: Jk3DefH2RguOzjF4wSLHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8943110"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:10:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 12:10:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 12:10:48 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 12:10:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTrmkAwmBfbNJnuAOkY+0V22VKgaki25VB1WSuvbbDXQSS3JRFz/tRBVuz8DUgVMnpX9V2rTH4Cjk5Z5Sjj44bvTCwzkrN/kZuZiTPo2gdlbPw5/kGFhAXSSWux31vNRMufMAoJZJdmNzRmahDWW4Rz1pC4jHFA91aI1iafWeRP7/O3o/LDHaln2R9xw3CT5ceHJyqrWVIiyPG45yVER/Dhpx9wxsfk4GYBEC+n6WUV4WNVe/+qetjhsFxvmzY4/cOFkuZffqhcSThe6FFiuzvbGhYKX0cAZiYPRwjqy6UhuKzyGQYYfApO3mH+byJsPAWkFU5GYIGo2ty7mUkfBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbujL9dvT6hVF3ZfTIwh4p8CjqctU7dcv8IoHJQdTIw=;
 b=hfQW9oDtid6FY5tUG/f0F+t+6clYarnHgdO2fcKuk2duWsx7+9aj1crsUkYSfwE1QvzElR9AHjbATSiRYaa+1iTNNlrz54XyUDmhsJtPjx15K9mXzew2g1p6WbmoYYXrSiA2IEi2vRNfB/LL8oU9suMi3S/haOGdg0CguqJYqAE79EdsHL/9fabemkpDFLUpzcqWErqEye9nt3UxOE3v7J3eTjPkwRQmF/vidFJDN/w6vwpudxXvNgFTwErqSS2qb/PSBe4G2x8eHf/hrm1aQV/L+brLG8twf0lx3qIy85P4NmYAN4k3AjuyInKJNLj39mQJtLuuJYUfNzOSbRbtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbujL9dvT6hVF3ZfTIwh4p8CjqctU7dcv8IoHJQdTIw=;
 b=G1qOsuhUvOdYydnvjm4ySZ/DekZ6iLWVy9mgo6/fmbjnk3aoM7gbg0d/1Nn6/uwS+BRVCrSp6fUUT0bNDMv1cMauo4A3EnaSLFoU4IFWDPWLKyL9TZorwhMvKGNRGdnX//+DA1hdXW5ggsQ+arTeVsHWOKg72vFgnCr9WCi0A/w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CC6PR11MB964443.namprd11.prod.outlook.com (2603:10b6:170:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:09:52 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 20:09:52 +0000
Date: Fri, 13 Nov 2026 12:09:49 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 28/33] drm/xe: Use IOVA-based DMA mapping for eligible
 tt BOs
Message-ID: <avdujVDHaYT3zi1b@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-29-matthew.brost@intel.com>
 <avat_NbhVqfLIyE7@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avat_NbhVqfLIyE7@nvishwa1-desk>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CC6PR11MB964443:EE_
X-MS-Office365-Filtering-Correlation-Id: cd30b857-60a9-4aa7-1ba8-08df41c21394
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|4143699003|261022113327099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261026140227099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5wlfx4kxQchWEfNNCxbSpwGaN09d3lq3EeS/MHRAcEIJJ2qTdQ4a/4ie0UhXBWw5+/Mecc51i3oGxS+1IcWqFPxmV2+qvBltzHaOOc/flUcWCf4FlRKS7JMeW9caGdynwWH3JvlxKiiP3nFChp+6G4EcLxqkFEzMfjYuosKNW6djbCjWoBERIssndV4FWKdiQykxlR6o3beAMIhDqxMfEJ0DXSlLLFqbtPRHUUraUjj6FySgJcSJs9y8oudhvGml5cZFbLwoQU4eQlMfAF2ZWXe8ikyOmdD6AMUx5R+bc7XpNjPujfHyG6AypjePbDzHvEsmmvMhwb4G5H1LhikeBECoj3qVz0RlYLTNQH6YuP2GzpiAmOwhNUQcxwtaZ1aZP3H+wqw+x+Ffsn3qfVf7xbWkcpXd6HzpRAsDwaJe+SXVmIAg+F/AljrJqok1oPHUuH0UGn0P/6L/CtdM/oND0H1ZhKxuppcgOJnbTu3gTfBrx2Sem3qZocTwCSgnrViLW82OXZh1oB+URjgeZmopMWRojJK9cUjT/C+urythym/TlnVPVb5j6sZnZU/VRfn2rTJDt9eoJuQDirJmvYymDt+TTBBknpXH+4FAhuiZ5xHuf2v38lpDLm2PqOiqCDTKDLLLoBSntCnsMvQZYAgmTMC71ii1K9IZm17DPXyOliE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261022113327099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nM0XFAD0TSmslL8xRUjewHQZGNLPuRgYC8XBDvr0rs12N/q5OcK8iji7Va?=
 =?iso-8859-1?Q?0Bw24NJfEesoWXWQGtlx9kf7PB+OL4L5nsnIqbpNgwbpE/r0yfxgZEobrn?=
 =?iso-8859-1?Q?ZBdvADeObIRoaTMyt7I6sw5vI7bM0IWbqD7MuAI/f8T5W1eIC4uxqgwXYV?=
 =?iso-8859-1?Q?fGitcltjpuysSiEsZfEvl1M5BNeLWlcpJ1P5txLTpEnX4Vs+tc5SwZMrIS?=
 =?iso-8859-1?Q?4yRZlrFdvIpBmLNlwyhkioiJEZj8JOXoRu1yypB7X4ksvbuoCoDvlmkXug?=
 =?iso-8859-1?Q?tksVXImCwJmmz+KFAh/IppHB6oPf5EgD+JSpZ4xnE3Sr3Fz3QNbL8W6usq?=
 =?iso-8859-1?Q?+mRSCeQaCoT4EegLL13uqwXlydkqu76J0HMiwZyLUmbrSS+94w4rpi0Ua3?=
 =?iso-8859-1?Q?PlGA5+CoLag3u3KdWh9lINLyWGKNOjuttXgcKVVWA4R1PWg7/TAXYxaJk7?=
 =?iso-8859-1?Q?vVIv8v9mtwy3l2b9yXbj8KMLYf1BnU8/Jg9iUkUMHpZnr1akdvNI2SHsxD?=
 =?iso-8859-1?Q?vHcEK5COm1HgOeMui9ApexQJUCUHCB4Qb/Y2fbOAphBggJCTbOZ5IHE2f9?=
 =?iso-8859-1?Q?Yp8VjdwP7OtEdR4gqA0h6Ql4Fs21QJAIeSkAfnHq9uRiywDMFMzj83kf+v?=
 =?iso-8859-1?Q?cDw634IvKGxaW5ZdGQE8g35zXg5vdTylh0/ecZafh0pQEjBA3IZI1MrOCU?=
 =?iso-8859-1?Q?jjARW40nlM/8HypGjURhld8Tkor1PoJH6enGL62U5RiyzPKLT5v5zlEA88?=
 =?iso-8859-1?Q?YEYV8i0YJjvOAC9cG9oIBoRkbB1zuXHos7KTpH0bPCJYBmhUqSSYElMrfl?=
 =?iso-8859-1?Q?1He57fYQpBecdxFZVkNn8v8lNeDaGmt1LqkY70DBzpkgMRJkGmUtJu3Etq?=
 =?iso-8859-1?Q?FppaQRzXNudzk+PYX/FBMWXGledijkJ7hrV76p3M5Ai+Ygv9LIEZFArwFR?=
 =?iso-8859-1?Q?XmwtFoLN79h/u0uAl8GiJsr2Otw38XKTFvYHhL2ZoeQQxVbKNwfxcucBEN?=
 =?iso-8859-1?Q?jD+PEDtaiGWzo3O9MiXweCY1adVQt+FySfZdXAYpRteuhTHax3aYXKcT26?=
 =?iso-8859-1?Q?xT7rCipOhwaHGddLk6YhC7IrQjcUBK/ejyqCeze+O+Tzex43caJPKLdIjc?=
 =?iso-8859-1?Q?uxt4E+biTzBLpHh09JkvYKoTHghxO3Dfo3iShdxql/Am94QAlcfC+IB4Gg?=
 =?iso-8859-1?Q?jxkJZEPND4PN1sFYdHNOVkXY+a64fCtwY08GapLpSH1ODU379J6/vTdzS7?=
 =?iso-8859-1?Q?5ynArHbu2PlHbF9vWKWZY+6wlEWY7wWYIVUnSd+lbHoIlh9WpWeHOq9Qb5?=
 =?iso-8859-1?Q?OYW8HfPRgEWuB4sCNytUNUUytFWCowxjJQhIg+Kfim1k1a4L+cta7ujrpd?=
 =?iso-8859-1?Q?YwBwxl9yQtlUrDGySZf1EKQYZrSNJnd2PuR6Jd1bQJMznm1/Xw7MQEpI+t?=
 =?iso-8859-1?Q?33sUdV0e2dH7NLxvGenQCfshWkcc1b1K4WEUJtBBHqY3z+KNXZo9aWsYV9?=
 =?iso-8859-1?Q?d18v0Mw6cX/gvM7UBMp7rXLLy25dLr+V3B3MD1lrFyByNA0wuwlcLAVd/F?=
 =?iso-8859-1?Q?+9riN754sWR505XRw/cB7AvbZbcPRpodhhc1iAAP8geASCxlJ7/WnRhSuC?=
 =?iso-8859-1?Q?BGBAPoKp9lCPFD2ClfJpZRi1YR6oj7+eWanaQkeX8Y+YQUFR4TBckKl+/0?=
 =?iso-8859-1?Q?9YWrD81qQ1E3ix+EZxvg95A/DT7LgTo53+D07EsI91im2ltMmJa78gJpkn?=
 =?iso-8859-1?Q?kHgu/+mZnKkhiWpwHu8nXD8qsWb5QFKWCB4AEWgvWpKaS5PbZTGofTzhUU?=
 =?iso-8859-1?Q?rvXSNH0z0A=3D=3D?=
X-Exchange-RoutingPolicyChecked: IPBA+fmngOH5INICB6lOOFuI4hpmm3E89H1HO0dJlCIDd0+jJBpiP93w2H+gVv5W7KAdqLuO3SF/3lO9aWszwj5ZNNPjPDs/p2h0kF9DiT1GoylvxeZ2Lnpu5BoAOvHfc9S9Hcw2Rv3MY9KPN5hr0y7xHwrTPpCFqiJjyCDiIWY5hRsItmw61VYUuCRw+g0tCyaRsljT3gwKw1m+1jObELxqfivzkKb2lpXQKZL7e1UEtm6E80bghqYTiD70bGepbR8Ro36Pp3EkVcxeuOkbXkDU3fZhDcNujUP0hDa1MdsjfW5VEas0a5pGmLUPH4sv6+w65CHzSpQWMa0RsAvrgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd30b857-60a9-4aa7-1ba8-08df41c21394
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:09:51.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgiofL5kE74mLlihH5KeBUss8InScFWDTu4XLkhHyOG2GYfNBfUBzK6ikHMPuCv2rKODDckospKwX3c0C/V+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB964443
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 10:28:12PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:14PM -0700, Matthew Brost wrote:
> > Add support for mapping a ttm_tt's pages using the IOVA-based DMA API
> > (dma_iova_try_alloc()/link()/sync()/unlink()/free()) as an alternative
> > to the scatter-gather list. An IOVA mapping is a single contiguous DMA
> > range, which is cheaper to walk and program than an sg list.
> > 
> > Whether the IOVA API can be used depends on the IOMMU mode, so the
> > decision is made once per tt at xe_ttm_tt_create() time and recorded in
> > struct xe_ttm_tt::use_iova. To keep the scope limited, only device BOs
> > that are not GGTT-mapped are eligible: dma-buf imports manage their own
> > mapping and GGTT bindings are programmed directly from the sg list.
> > dma_iova_try_alloc() may still fail, in which case the tt transparently
> > falls back to the sg list, which remains the default.
> > 
> > The IOVA reservation is allocated at tt creation and freed at tt
> > destroy. xe_tt_map_iova() links the tt pages (coalescing physically
> > contiguous runs) and syncs the IOTLB; xe_tt_unmap_iova() unlinks them
> > but keeps the reservation so the tt can be remapped without
> > re-allocating IOVA space. xe_tt_map()/xe_tt_unmap() dispatch between the
> > IOVA and sg backends, and xe_bo_dma_unmap_pinned() learns about the IOVA
> > case.
> > 
> > Consumers that walked the sg list via xe_res_first_sg(xe_bo_sg()) now go
> > through the new xe_res_first_tt() helper, which initializes either an
> > IOVA cursor (xe_res_first_iova()) or an sg cursor depending on the tt's
> > mapping mode.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/tests/xe_migrate.c |   6 +-
> > drivers/gpu/drm/xe/xe_bo.c            | 239 ++++++++++++++++++++++++--
> > drivers/gpu/drm/xe/xe_bo.h            |   5 +-
> > drivers/gpu/drm/xe/xe_ggtt.c          |   2 +-
> > drivers/gpu/drm/xe/xe_migrate.c       |  14 +-
> > drivers/gpu/drm/xe/xe_pt.c            |   2 +-
> > 6 files changed, 237 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
> > index 41de648b2c86..119134e67c89 100644
> > --- a/drivers/gpu/drm/xe/tests/xe_migrate.c
> > +++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
> > @@ -253,7 +253,7 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test,
> > 	if (xe_bo_is_vram(pt))
> > 		xe_res_first(pt->ttm.resource, 0, xe_bo_size(pt), &src_it);
> > 	else
> > -		xe_res_first_sg(xe_bo_sg(pt), 0, xe_bo_size(pt), &src_it);
> > +		xe_res_first_tt(pt->ttm.ttm, 0, xe_bo_size(pt), &src_it);
> > 
> > 	emit_pte(m, bb, NUM_KERNEL_PDE - 1, xe_bo_is_vram(pt), false,
> > 		 &src_it, XE_PAGE_SIZE, pt->ttm.resource);
> > @@ -385,12 +385,12 @@ static struct dma_fence *blt_copy(struct xe_tile *tile,
> > 	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
> > 
> > 	if (!src_is_vram)
> > -		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
> > +		xe_res_first_tt(src_bo->ttm.ttm, 0, size, &src_it);
> > 	else
> > 		xe_res_first(src, 0, size, &src_it);
> > 
> > 	if (!dst_is_vram)
> > -		xe_res_first_sg(xe_bo_sg(dst_bo), 0, size, &dst_it);
> > +		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
> > 	else
> > 		xe_res_first(dst, 0, size, &dst_it);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index caf5aa0bab53..d54e69aefeba 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -6,6 +6,7 @@
> > #include "xe_bo.h"
> > 
> > #include <linux/dma-buf.h>
> > +#include <linux/dma-mapping.h>
> > #include <linux/nospec.h>
> > 
> > #include <drm/drm_drv.h>
> > @@ -15,6 +16,7 @@
> > #include <drm/ttm/ttm_backup.h>
> > #include <drm/ttm/ttm_device.h>
> > #include <drm/ttm/ttm_placement.h>
> > +#include <drm/ttm/ttm_pool.h>
> > #include <drm/ttm/ttm_tt.h>
> > #include <uapi/drm/xe_drm.h>
> > 
> > @@ -420,6 +422,32 @@ struct xe_ttm_tt {
> > 	struct ttm_tt ttm;
> > 	struct sg_table sgt;
> > 	struct sg_table *sg;
> > +	/**
> > +	 * @iova: IOVA state describing the single contiguous IOVA mapping of
> > +	 * the tt pages. Only valid when @use_iova is true.
> > +	 */
> > +	struct dma_iova_state iova;
> > +	/**
> > +	 * @use_iova: Whether this tt is DMA mapped using the IOVA-based DMA
> > +	 * API instead of a scatter-gather list. Decided once at tt creation
> > +	 * time and stable for the lifetime of the tt.
> > +	 */
> > +	bool use_iova;
> > +	/**
> > +	 * @iova_linked: Whether the tt pages are currently linked into the
> > +	 * IOVA mapping. Only meaningful when @use_iova is true.
> > +	 */
> > +	bool iova_linked;
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	/**
> > +	 * @iova_dma_pages: Per-order count of DMA-mapped pages this tt
> > +	 * accounted into xe->mem.dma_mapped_pages[] for its IOVA mapping,
> > +	 * recorded at link time so the unlink can apply an exactly matching
> > +	 * decrement without re-walking tt->pages (which TTM may mutate, e.g.
> > +	 * during defrag). Counter ownership stays isolated in xe_bo.c.
> > +	 */
> > +	unsigned long iova_dma_pages[NR_PAGE_ORDERS];
> > +#endif
> > 	/** @purgeable: Whether the content of the pages of @ttm is purgeable. */
> > 	bool purgeable;
> > };
> > @@ -468,6 +496,52 @@ static void xe_tt_account_dma_pages(struct xe_device *xe,
> > }
> > #endif
> > 
> > +/*
> > + * xe_tt_account_iova_add - account one freshly linked IOVA folio
> > + * @xe: the xe device
> > + * @xe_tt: the xe_ttm_tt being mapped
> > + * @order: page order of the linked folio
> > + *
> > + * Add the folio's 2^order pages to xe->mem.dma_mapped_pages[order] and record
> > + * the same amount in @xe_tt so xe_tt_unaccount_iova() can later subtract an
> > + * exactly matching count without re-walking tt->pages.
> > + */
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +static void xe_tt_account_iova_add(struct xe_device *xe,
> > +				   struct xe_ttm_tt *xe_tt, unsigned int order)
> > +{
> > +	unsigned long chunk = 1UL << order;
> > +
> > +	xe_tt->iova_dma_pages[order] += chunk;
> > +	atomic_long_add(chunk, &xe->mem.dma_mapped_pages[order]);
> > +}
> > +
> > +static void xe_tt_unaccount_iova(struct xe_device *xe,
> > +				 struct xe_ttm_tt *xe_tt)
> > +{
> > +	unsigned int order;
> > +
> > +	for (order = 0; order < NR_PAGE_ORDERS; order++) {
> > +		unsigned long pages = xe_tt->iova_dma_pages[order];
> > +
> > +		if (pages) {
> > +			atomic_long_sub(pages, &xe->mem.dma_mapped_pages[order]);
> > +			xe_tt->iova_dma_pages[order] = 0;
> > +		}
> > +	}
> > +}
> > +#else
> > +static void xe_tt_account_iova_add(struct xe_device *xe,
> > +				   struct xe_ttm_tt *xe_tt, unsigned int order)
> > +{
> > +}
> > +
> > +static void xe_tt_unaccount_iova(struct xe_device *xe,
> > +				 struct xe_ttm_tt *xe_tt)
> > +{
> > +}
> > +#endif
> 
> Assisted-by: LLM
> 

Yes.

> NIT..As mentioned in patch 12, I am not sure if CONFIG_DEBUG_FS is the
> right config for this. May be XE_DEBUG would be better?
> 

Again I think CONFIG_DEBUG_FS is desired config. We want these stats on
most production builds for debug - not just CI configs.

The only case we wouldn't want these is some crazy data center config
that literally turns off all debug things. Same idea as GT stats not
having its own Kconfig.

> > +
> > static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> > {
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > @@ -514,28 +588,129 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
> > 	}
> > }
> > 
> > -struct sg_table *xe_bo_sg(struct xe_bo *bo)
> > +/*
> > + * xe_tt_map_iova - DMA map a tt using the IOVA-based DMA API.
> > + *
> > + * Link all of the tt's pages into the IOVA range reserved at tt creation
> > + * time, one folio at a time, and sync the IOTLB once at the end. The IOVA
> > + * reservation itself is kept across map/unmap cycles and only released when
> > + * the tt is destroyed.
> > + */
> > +static int xe_tt_map_iova(struct xe_device *xe, struct ttm_tt *tt)
> > {
> > -	struct ttm_tt *tt = bo->ttm.ttm;
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > +	struct device *dev = xe->drm.dev;
> > +	unsigned long num_pages = tt->num_pages;
> > +	unsigned long i = 0;
> > +	size_t mapped = 0;
> > +	int ret;
> > +
> > +	if (xe_tt->iova_linked)
> > +		return 0;
> > +
> > +	while (i < num_pages) {
> > +		struct page *page = tt->pages[i];
> > +		unsigned int order = ttm_pool_page_order_nodma(page);
> > +		size_t len = PAGE_SIZE << order;
> 
> NIT...as ttm_pool_page_order_nodma() is works only at chunk head
> (where order is stored in page->private), it should be fine.
> But if we ever endup here for pages[i] other than chunk head, it
> would become hard to debug. Is there a way we can assert for that here?
> 

I don't see an easy to determine page is a head page or not. TTM pages
are all non-compound - we do want to fix that - right now AFIAK we set
p->private to the order for only head pages and zero is a valid order.

> > +
> > +		ret = dma_iova_link(dev, &xe_tt->iova, page_to_phys(page),
> > +				    mapped, len, DMA_BIDIRECTIONAL,
> > +				    DMA_ATTR_SKIP_CPU_SYNC);
> > +		if (ret)
> > +			goto err_unlink;
> > 
> > -	return xe_tt->sg;
> > +		xe_tt_account_iova_add(xe, xe_tt, order);
> > +		mapped += len;
> > +		i += 1UL << order;
> > +	}
> > +
> > +	ret = dma_iova_sync(dev, &xe_tt->iova, 0, mapped);
> > +	if (ret)
> > +		goto err_unlink;
> > +
> > +	xe_tt->iova_linked = true;
> > +	return 0;
> > +
> > +err_unlink:
> > +	if (mapped) {
> > +		dma_iova_unlink(dev, &xe_tt->iova, 0, mapped,
> > +				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
> > +		xe_tt_unaccount_iova(xe, xe_tt);
> > +	}
> > +	return ret;
> > }
> > 
> > -/**
> > - * xe_tt_sg() - Return the DMA scatter-gather table backing a ttm_tt.
> > - * @tt: The ttm_tt to query.
> > +/*
> > + * xe_tt_unmap_iova - Unlink a tt's pages from its IOVA mapping.
> >  *
> > - * Like xe_bo_sg(), but takes the ttm_tt directly. Used by the defrag copy
> > - * path which needs the old (source) tt's sg table without a backing xe_bo.
> > + * Unlink the pages but keep the IOVA reservation so the tt can be remapped
> > + * later without re-allocating IOVA space.
> > + */
> > +static void xe_tt_unmap_iova(struct xe_device *xe, struct ttm_tt *tt)
> > +{
> > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > +
> > +	if (xe_tt->iova_linked) {
> > +		/*
> > +		 * Unmap with attrs 0 (matching the sg unmap path) so that the
> > +		 * CPU copy-back sync is performed for non-coherent or bounced
> > +		 * (SWIOTLB) mappings, even though the link was done with
> > +		 * DMA_ATTR_SKIP_CPU_SYNC.
> > +		 */
> > +		dma_iova_unlink(xe->drm.dev, &xe_tt->iova, 0,
> > +				dma_iova_size(&xe_tt->iova),
> > +				DMA_BIDIRECTIONAL, 0);
> > +		xe_tt_unaccount_iova(xe, xe_tt);
> > +		xe_tt->iova_linked = false;
> > +	}
> > +}
> > +
> > +/*
> > + * xe_tt_map - DMA map a tt, using IOVA when available and sg otherwise.
> > + */
> > +static int xe_tt_map(struct xe_device *xe, struct ttm_tt *tt)
> > +{
> > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > +
> > +	if (xe_tt->use_iova)
> > +		return xe_tt_map_iova(xe, tt);
> > +
> > +	return xe_tt_map_sg(xe, tt);
> > +}
> > +
> > +/*
> > + * xe_tt_unmap - Undo xe_tt_map().
> > + */
> > +static void xe_tt_unmap(struct xe_device *xe, struct ttm_tt *tt)
> > +{
> > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > +
> > +	if (xe_tt->use_iova)
> > +		xe_tt_unmap_iova(xe, tt);
> > +	else
> > +		xe_tt_unmap_sg(xe, tt);
> > +}
> > +
> > +/**
> > + * xe_res_first_tt() - Initialize a resource cursor over a ttm_tt's DMA mapping.
> > + * @tt: The ttm_tt to walk.
> > + * @start: Start of the range, in bytes.
> > + * @size: Size of the range, in bytes.
> > + * @cur: The cursor to initialize.
> >  *
> > - * Return: The sg table, or NULL if the tt is not currently mapped.
> > + * Initialize @cur to walk the DMA addresses backing @tt, transparently
> > + * handling both the IOVA-based mapping (single contiguous range) and the
> > + * scatter-gather list fallback.
> >  */
> > -struct sg_table *xe_tt_sg(struct ttm_tt *tt)
> > +void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
> > +		     struct xe_res_cursor *cur)
> > {
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > 
> > -	return xe_tt->sg;
> > +	if (xe_tt->use_iova)
> > +		xe_res_first_iova(&xe_tt->iova, start, size, cur);
> > +	else
> > +		xe_res_first_sg(xe_tt->sg, start, size, cur);
> > }
> > 
> > /*
> > @@ -651,6 +826,21 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
> > 		}
> > 	}
> > 
> > +	/*
> > +	 * Eligible BOs are DMA mapped using the IOVA-based DMA API, which
> > +	 * yields a single contiguous IOVA range instead of a scatter-gather
> > +	 * list. Only device BOs that are not GGTT-mapped qualify: dma-buf
> > +	 * imports manage their own mapping and GGTT bindings are programmed
> > +	 * directly from the sg list. dma_iova_try_alloc() may still fail
> > +	 * depending on the IOMMU mode, in which case we transparently fall
> > +	 * back to the sg list. The reservation lives for the tt's lifetime.
> > +	 */
> > +	if (ttm_bo->type != ttm_bo_type_sg &&
> > +	    !(bo->flags & (XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_ALL)) &&
> > +	    dma_iova_try_alloc(xe->drm.dev, &xe_tt->iova, 0,
> > +			       (size_t)tt->num_pages << PAGE_SHIFT))
> > +		xe_tt->use_iova = true;
> 
> Shouldn't we be allocating 2M aligned iova here by passing 2M to 'phys'
> instead of 0? We need both 2M aligned iova and 2M aligned physical address
> (beneficial order) which defragmentation expected to provide by benefecial
> order, right?
> 

I thought this API worked that way and when I add iova support to GPUSVM
I coded it this way, but it appears to not be needed:

git format-patch -1 9175f49330d19

^^^ This removed passing in 2M.

Matt

> Niranjana
> 
> > +
> > 	return tt;
> > }
> > 
> > @@ -700,7 +890,7 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> > 	    !(tt->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE))
> > 		return;
> > 
> > -	xe_tt_unmap_sg(xe, tt);
> > +	xe_tt_unmap(xe, tt);
> > 
> > 	ttm_pool_free(&ttm_dev->pool, tt);
> > 	xe_ttm_tt_account_subtract(xe, tt);
> > @@ -709,6 +899,19 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> > 
> > static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> > {
> > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > +
> > +	/*
> > +	 * Release the IOVA reservation made in xe_ttm_tt_create(). The pages
> > +	 * must already have been unlinked by xe_tt_unmap().
> > +	 */
> > +	if (xe_tt->use_iova) {
> > +		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
> > +
> > +		xe_assert(xe, !xe_tt->iova_linked);
> > +		dma_iova_free(xe->drm.dev, &xe_tt->iova);
> > +	}
> > +
> > 	ttm_tt_fini(tt);
> > 	kfree(tt);
> > }
> > @@ -1557,7 +1760,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 	/* Bo creation path, moving to system or TT. */
> > 	if ((!old_mem && ttm) && !handle_system_ccs) {
> > 		if (new_mem->mem_type == XE_PL_TT)
> > -			ret = xe_tt_map_sg(xe, ttm);
> > +			ret = xe_tt_map(xe, ttm);
> > 		if (!ret)
> > 			ttm_bo_move_null(ttm_bo, new_mem);
> > 		goto out;
> > @@ -1587,7 +1790,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 		(!ttm && ttm_bo->type == ttm_bo_type_device);
> > 
> > 	if (new_mem->mem_type == XE_PL_TT) {
> > -		ret = xe_tt_map_sg(xe, ttm);
> > +		ret = xe_tt_map(xe, ttm);
> > 		if (ret)
> > 			goto out;
> > 	}
> > @@ -1757,7 +1960,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > 		if (IS_VF_CCS_READY(xe))
> > 			xe_sriov_vf_ccs_detach_bo(bo);
> > 
> > -		xe_tt_unmap_sg(xe, ttm_bo->ttm);
> > +		xe_tt_unmap(xe, ttm_bo->ttm);
> > 	}
> > 
> > 	xe_bo_defrag_update(bo);
> > @@ -1785,7 +1988,7 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
> > 		if (lret)
> > 			return lret;
> > 
> > -		xe_tt_unmap_sg(xe, bo->ttm);
> > +		xe_tt_unmap(xe, bo->ttm);
> > 		ttm_bo_move_null(bo, new_resource);
> > 	}
> > 
> > @@ -2212,6 +2415,8 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
> > 						 DMA_BIDIRECTIONAL);
> > 			ttm_bo->sg = NULL;
> > 			xe_tt->sg = NULL;
> > +		} else if (xe_tt->use_iova) {
> > +			xe_tt_unmap_iova(ttm_to_xe_device(ttm_bo->bdev), tt);
> > 		} else if (xe_tt->sg) {
> > 			dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
> > 					  xe_tt->sg,
> > @@ -3779,7 +3984,7 @@ dma_addr_t __xe_bo_addr(struct xe_bo *bo, u64 offset, size_t page_size)
> > 	if (!xe_bo_is_vram(bo) && !xe_bo_is_stolen(bo)) {
> > 		xe_assert(xe, bo->ttm.ttm);
> > 
> > -		xe_res_first_sg(xe_bo_sg(bo), page << PAGE_SHIFT,
> > +		xe_res_first_tt(bo->ttm.ttm, page << PAGE_SHIFT,
> > 				page_size, &cur);
> > 		return xe_res_dma(&cur) + offset;
> > 	} else {
> > diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> > index 18fcccd082b7..3e2eaefecb8f 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > @@ -552,8 +552,9 @@ void xe_bo_dev_init(struct xe_bo_dev *bo_device);
> > 
> > void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
> > 
> > -struct sg_table *xe_bo_sg(struct xe_bo *bo);
> > -struct sg_table *xe_tt_sg(struct ttm_tt *tt);
> > +struct xe_res_cursor;
> > +void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
> > +		     struct xe_res_cursor *cur);
> > 
> > /*
> >  * xe_sg_segment_size() - Provides upper limit for sg segment size.
> > diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> > index 8ec23862477f..4084bc183e06 100644
> > --- a/drivers/gpu/drm/xe/xe_ggtt.c
> > +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> > @@ -699,7 +699,7 @@ static void xe_ggtt_map_bo(struct xe_ggtt *ggtt, struct xe_ggtt_node *node,
> > 	if (!xe_bo_is_vram(bo) && !xe_bo_is_stolen(bo)) {
> > 		xe_assert(xe_bo_device(bo), bo->ttm.ttm);
> > 
> > -		for (xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &cur);
> > +		for (xe_res_first_tt(bo->ttm.ttm, 0, xe_bo_size(bo), &cur);
> > 		     cur.remaining; xe_res_next(&cur, XE_PAGE_SIZE))
> > 			ggtt->pt_ops->ggtt_set_pte(ggtt, end - cur.remaining,
> > 						   pte | xe_res_dma(&cur));
> > diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> > index 9990a7144a9f..666c715a9067 100644
> > --- a/drivers/gpu/drm/xe/xe_migrate.c
> > +++ b/drivers/gpu/drm/xe/xe_migrate.c
> > @@ -1005,16 +1005,16 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > 		return ERR_PTR(-EINVAL);
> > 
> > 	if (!src_is_vram)
> > -		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo), 0, size, &src_it);
> > +		xe_res_first_tt(src_tt ? src_tt : src_bo->ttm.ttm, 0, size, &src_it);
> > 	else
> > 		xe_res_first(src, 0, size, &src_it);
> > 	if (!dst_is_vram)
> > -		xe_res_first_sg(xe_bo_sg(dst_bo), 0, size, &dst_it);
> > +		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
> > 	else
> > 		xe_res_first(dst, 0, size, &dst_it);
> > 
> > 	if (copy_system_ccs)
> > -		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo),
> > +		xe_res_first_tt(src_tt ? src_tt : src_bo->ttm.ttm,
> > 				xe_bo_ccs_pages_start(src_bo),
> > 				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> > 				&ccs_it);
> > @@ -1383,9 +1383,9 @@ int xe_migrate_ccs_rw_copy(struct xe_tile *tile, struct xe_exec_queue *q,
> > 
> > 	ctx = &xe->sriov.vf.ccs.contexts[read_write];
> > 
> > -	xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
> > +	xe_res_first_tt(src_bo->ttm.ttm, 0, size, &src_it);
> > 
> > -	xe_res_first_sg(xe_bo_sg(src_bo), xe_bo_ccs_pages_start(src_bo),
> > +	xe_res_first_tt(src_bo->ttm.ttm, xe_bo_ccs_pages_start(src_bo),
> > 			PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> > 			&ccs_it);
> > 
> > @@ -1588,7 +1588,7 @@ struct dma_fence *xe_migrate_vram_copy_chunk(struct xe_bo *vram_bo, u64 vram_off
> > 	xe_assert(xe, !range_overflows(sysmem_offset, size, (u64)sysmem_bo->ttm.base.size));
> > 
> > 	xe_res_first(vram, vram_offset, size, &vram_it);
> > -	xe_res_first_sg(xe_bo_sg(sysmem_bo), sysmem_offset, size, &sysmem_it);
> > +	xe_res_first_tt(sysmem_bo->ttm.ttm, sysmem_offset, size, &sysmem_it);
> > 
> > 	while (size) {
> > 		u32 pte_flags = PTE_UPDATE_FLAG_IS_VRAM;
> > @@ -1800,7 +1800,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
> > 		clear_only_system_ccs = true;
> > 
> > 	if (!clear_vram)
> > -		xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &src_it);
> > +		xe_res_first_tt(bo->ttm.ttm, 0, xe_bo_size(bo), &src_it);
> > 	else
> > 		xe_res_first(src, 0, xe_bo_size(bo), &src_it);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> > index 7111b5d0f6aa..185d15fb0a97 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -797,7 +797,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
> > 			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
> > 				     xe_vma_size(vma), &curs);
> > 		else
> > -			xe_res_first_sg(xe_bo_sg(bo), xe_vma_bo_offset(vma),
> > +			xe_res_first_tt(bo->ttm.ttm, xe_vma_bo_offset(vma),
> > 					xe_vma_size(vma), &curs);
> > 	} else if (!range) {
> > 		curs.size = xe_vma_size(vma);
> > -- 
> > 2.34.1
> > 
